#!/bin/bash

apt-get install virtualenv

echo "Installing postfix and mailutils"
    debconf-set-selections <<< "postfix postfix/mailname string do-portal"
    debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
    sudo apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules -y

echo "Copying mailman from files"
    #su vagrant -s /bin/bash -c "sudo cp -R /vagrant/files/mailman /srv && sudo chown vagrant:vagrant -R /srv/mailman"
    sudo mkdir /srv/mailman
    chown vagrant:vagrant /srv/mailman
    cp -R /vagrant/files/mailman /srv && sudo chown vagrant:vagrant -R /srv/mailman

echo "create python3 env for mailman"
    su vagrant -s /bin/bash -c "cd /srv/mailman && virtualenv -p python3 py3 "

echo "Setup mailman for py3 environment"
#    sudo su vagrant -s /bin/bash -c "cd /srv/mailman/mailman; source /srv/mailman/py3/bin/activate && ../py3/bin/python3.4 ./setup.py install"
    cd /srv/mailman/mailman
    /srv/mailman/py3/bin/python3.4 ./setup.py install

echo "Setup mailmanclient for py3 env"
#    sudo su vagrant -s /bin/bash -c "cd /srv/mailman/mailmanclient; source /srv/mailman/py3/bin/activate && ../py3/bin/python3.4 ./setup.py install"
    /srv/mailman/py3/bin/pip3.4 install /srv/mailman/mailmanclient

echo "Copy mailman.service config from files"
    su vagrant -s /bin/bash -c "sudo cp /vagrant/files/configs/mailman/mailman.service /lib/systemd/system"

echo "Copy mailman config to /srv/mailman"
    su vagrant -s /bin/bash -c "sudo cp /vagrant/files/configs/mailman/mailman.cfg /srv/mailman/mailman.cfg"
   
echo "Enable mailman service"
    su vagrant -s /bin/bash -c "sudo systemctl enable mailman.service"
    su vagrant -s /bin/bash -c "sudo systemctl start mailman.service"
