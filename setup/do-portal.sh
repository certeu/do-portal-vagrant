#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Copy do-portal to /srv
echo "Syncing do-portal to /srv"
    rsync -aP --delete /vagrant/files/do-portal/ /srv/do-portal
    rsync -aP --delete /vagrant/files/configs/doportal/* /srv/do-portal

# Create doportal user
#    useradd -r -s /sbin/nologin doportal

# Change owner of do-portal
#    chown doportal:doportal -R /srv/do-portal

# copy celery service file and defaults file to appropriate locations
echo "Copying celery configs"
    cp -p /vagrant/files/configs/systemd/celery.service /lib/systemd/system
    cp -p /vagrant/files/configs/systemd/celery /etc/default
#    chown root:root /lib/systemd/system/celery.service

# Enable celery.service
    systemctl enable celery.service

# create virtual environment
echo "Creating python virtual environment"
    cd /srv/do-portal; virtualenv -p python3 venv

# add globally celery variables
# this is there to be able to debug celery issues

echo "Setting celery globals"
    echo "DO_LOCAL_CONFIG=\"/srv/do-portal/config.cfg\"" >> /etc/environment
    echo "CELERY_APP=\"tasks.celery\"" >> /etc/environment
    echo "CELERYD_NODES=\"w1 w2\"" >> /etc/environment
    echo "CELERYD_OPTS=\"\"" >> /etc/environment
    echo "CELERY_BIN=\"/srv/do-portal/venv/bin/celery\"" >> /etc/environment
    echo "CELERYD_PID_FILE=\"/var/run/celery/%n.pid\"" >> /etc/environment
    echo "CELERYD_LOG_FILE=\"/var/log/celery/%n.log\"" >> /etc/environment
    echo "CELERYD_LOG_LEVEL=\"DEBUG\"" >> /etc/environment

# Install celery for python

echo "Installing python celery"
    cd /srv/do-portal
    venv/bin/pip3.4 install uwsgi
    venv/bin/pip3.4 install celery
    venv/bin/pip3.4 install pymysql
    venv/bin/pip3.4 install jsonschema
    venv/bin/pip3.4 install git+https://github.com/certeu/Flask-Tinyclients.git
    venv/bin/pip3.4 install git+https://github.com/ics/Flask-GnuPG.git
    venv/bin/pip3.4 install git+https://github.com/ics/domainfuzzer.git
    venv/bin/pip3.4 install -r requirements.txt

echo "Setting correct owner for celery log dir"
    chown vagrant /var/log/celery

# Create database for do-portal
echo "Creating do-portal database"
    mysql -u root -ptoor -e "create database do_portal"

# Create a logs dir, TODO: figure out rights and what should actually
# create that dir and files, atm, doing it manually
echo "Creating directorys"
    mkdir /srv/do-portal/logs; mkdir /srv/do-portal/.gnupg
    chmod 775 /srv/do-portal/logs
    chown vagrant /srv/do-portal/logs
    su vagrant -c "mkdir -p /srv/do-portal/app/static/data/samples/"

# Create database tables
# Running manage.py will create the file audit.log into logs dir. Running manage.py as doportal
echo "Creating tables for database do_portal"
    su vagrant -c "/srv/do-portal/venv/bin/python /srv/do-portal/manage.py db upgrade"
    su vagrant -c "/srv/do-portal/venv/bin/python /srv/do-portal/manage.py add_sample_data"

# add relevant groups for user vagrant
# echo "adding groups for vagrant user"
#    usermod -a -G doportal vagrant

# Setup NGINX

echo "patching do-portal"
    patch -p0 /srv/do-portal/venv/lib/python3.4/site-packages/flask_jsonschema.py /srv/do-portal/misc/patches/flask_jsonschema.patch

echo "Installing trid tools"
    cp -Rp /vagrant/files/trid/* /usr/local/bin
    chmod +x /usr/local/bin/trid

echo "Creating uwsgi configs"
    cp -p /vagrant/files/configs/uwsgi/doportal.ini /etc/uwsgi/apps-enabled
    /etc/init.d/uwsgi restart

echo "Creating nginx configs"
    cp -p /vagrant/files/configs/nginx/doportal.conf /etc/nginx/sites-enabled
    rm -f /etc/nginx/sites-enabled/default
    /etc/init.d/nginx restart

echo "Starting celery"
    systemctl restart celery.service

echo "staring ClamAV"
    systemctl restart clamav-daemon.service
    systemctl restart clamav-freshclam.service
#echo "Result of ifconfig"
#    ifconfig
