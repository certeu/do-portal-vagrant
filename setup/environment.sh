#!/bin/bash

# Fix dpkg-preconfigure error
export DEBIAN_FRONTEND=noninteractive

# Update perl locales
echo "Updateing locales"
    export LANGUAGE=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    locale-gen "en_US.UTF-8"
#    dpkg-reconfigure locales

# change hostname
echo "changeing hostname"
    hostname doportal
    echo "doportal" > /etc/hostname

# replace hosts file
echo "replaceing hosts file"
    cp -f /vagrant/files/hosts /etc/hosts
