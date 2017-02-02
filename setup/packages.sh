#!/bin/bash

# Variables
MYSQLPW=toor
OS=$(lsb_release -si)

# fix dpkg-preconfigure error
export DEBIAN_FRONTEND=noninteractive

echo " "
echo "========================="
echo "## Setting up packages ##"
echo "========================="
echo " "


# update repo
echo "checking distro"
    if [ $OS == "Debian" ]; then
        echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
#    elif [ $OS == "Ubuntu" ]; then
    fi

echo "updateing apt repositories"
    apt-get update

# install git
echo "installing git"
    apt-get install git -y > /dev/null
# Case its Debian, installing vim
    if [ $OS == "Debian" ]; then
        echo "Installing vim"
        apt-get install vim -y
        echo "syntax on" >> /etc/vim/vimrc
    fi

# Install MySQL
echo "installing mysql"
    echo "mysql root password is: $MYSQLPW"
    echo "mysql-server mysql-server/root_password password $MYSQLPW" | debconf-set-selections
    echo "mysql-server mysql-server/root_password_again password $MYSQLPW" | debconf-set-selections
    apt-get install -y mysql-server

# Install Nginx
echo "installing nginx"
    apt-get install nginx -y

# Instal do-portal requierments
echo "Installing do-portal requierments"
    apt-get install ssdeep exiftool libfuzzy-dev libffi-dev p7zip-full virtualenv -y

# Install forensics-tools
echo "Installing forensics tools"
    debconf-set-selections <<< "postfix postfix/mailname string do-portal"
    debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
    apt-get install forensics-all -y

# Install RabbitMQ
echo "Installing RabbitMQ"
    apt-get install rabbitmq-server -y
    # create user and set password
    rabbitmqctl add_user doportal doportal
    # set domain to doportal
    rabbitmqctl add_vhost doportal_vhost
    rabbitmqctl set_user_tags doportal do
    # add presmissions
    rabbitmqctl set_permissions -p doportal_vhost doportal ".*" ".*" ".*"

# Install Celery
echo "Installing Celery"
    apt-get install celeryd -y

# Install common python dependancies
echo "Installing compiler dependancies"
    apt-get install gcc build-essential libssl-dev libffi-dev python-dev python3-dev libncurses5-dev libxml2-dev libxslt1-dev libgeoip-dev -y

# Install uwsgi and plugin for python3
echo "Installing uWSGI"
    apt-get install uwsgi -y
    apt-get install uwsgi-plugin-python3 -y

# Install ClamAV
echo "Installing ClamAV"
    apt-get install clamav-daemon clamav -y
