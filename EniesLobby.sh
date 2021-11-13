#!/bin/bash

apt-get update
apt-get install nano
apt-get install bind9 -y
sed -i '21iforwarders {\n         192.168.122.1;\n};' /etc/bind/named.conf.options
sed -i "s_dnssec-validation auto;_//dnssec-validation auto;_g" /etc/bind/named.conf.options
sed -i '25i     allow-query{any;};' /etc/bind/named.conf.options
echo 'zone "super.franky.t11.com" {
        type master;
        file "/etc/bind/super/super.franky.t11.com";
};' >> /etc/bind/named.conf.local
mkdir /etc/bind/super/
cp /etc/bind/db.local /etc/bind/super/super.franky.t11.com
echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     super.franky.t11.com. root.super.franky.t11.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      super.franky.t11.com.
@       IN      A       10.47.3.69
@       IN      AAAA    ::1' > /etc/bind/super/super.franky.t11.com
service bind9 restart
 
