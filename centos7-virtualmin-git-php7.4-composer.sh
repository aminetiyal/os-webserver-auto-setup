#!/bin/bash
# This block defines the variables the user of the script needs to input
# when deploying using this script.
#
#
#<UDF name="hostname" label="The hostname for the new Linode.">
# HOSTNAME=
#


# Update packages
yum -y update

# set TimeZone to Casablanca
timedatectl set-timezone 'Africa/Casablanca'

# set hostname
hostnamectl set-hostname $HOSTNAME


# Install wget
yum -y install wget

# Download virtualmin
wget http://software.virtualmin.com/gpl/scripts/install.sh

# Install virtualmin
/bin/sh install.sh --hostname $HOSTNAME --force

# Install Git
yum -y install git

# Install Yum-utils
yum -y install yum-utils

# Add epel-release
yum -y install epel-release

# Install PHP7.4
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum -y install php7.4-cli
yum --enablerepo=remi-php74 -y install php-xml php-soap php-xmlrpc php-mbstring php-json php-gd php-mcrypt php-zip

# Install Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php

# Make composer global
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
