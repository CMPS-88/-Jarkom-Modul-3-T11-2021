#!/bin/bash

apt-get install nano
apt-get update
apt-get install apache2 -y
apt-get install php -y
apt-get install libapache2-mod-php7.0 -y
apt-get install wget
wget https://raw.githubusercontent.com/FeinardSlim/Praktikum-Modul-2-Jarkom/main/super.franky.zip
apt-get install unzip
unzip super.franky.zip
mkdir /var/www/super.franky.t11.com
mv  -v /super.franky/* /var/www/super.franky.t11.com
sed -i "s_DocumentRoot /var/www/html_DocumentRoot /var/www/super.franky.t11.com_g" /etc/apache2/sites-available/000-default.conf
sed -i "14iServerName super.franky.t11.com" /etc/apache2/sites-available/000-default.conf
service apache2 restart
