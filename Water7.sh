#!/bin/bash
#!/bin/bash

echo nameserver 10.47.2.2 > /etc/resolv.conf
echo nameserver 192.168.122.1 >> /etc/resolv.conf
apt-get install nano
apt-get update
apt-get install squid -y
mv /etc/squid/squid.conf /etc/squid/squid.conf.bak
touch /etc/squid/squid.conf
echo 'http_port 5000
visible_hostname jualbelikapal.t11.com' > /etc/squid/squid.conf
apt-get install apache2-utils -y
htpasswd -c -b -m /etc/squid/passwd luffybelikapalt11 luffy_t11
htpasswd -b -m /etc/squid/passwd zorobelikapalt11 zoro_t11
echo 'auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Proxy
auth_param basic credentialsttl 2 hours
auth_param basic casesensitive on
acl USERS proxy_auth REQUIRED
acl awas url_regex .google.com
acl magic_words url_regex -i \.png$ \.jpg$
acl Good_Users proxy_auth luffybelikapalt11
delay_pools 1
delay_class 1 1
delay_parameters 1 1250/2000
delay_access 1 allow magic_words Good_Users
delay_access 1 deny ALL
http_access deny awas
http_access allow USERS AVAILABLE_WORKING
http_access allow USERS AVAILABLE
http_access allow USERS BISA
deny_info http://super.franky.t11.com/ awas
http_access deny all' >> /etc/squid/squid.conf
touch /etc/squid/acl.conf
echo 'acl AVAILABLE_WORKING time MTWH 07:00-11:00' > /etc/squid/acl.conf
echo 'acl AVAILABLE time TWHF 17:00-23:59' >> /etc/squid/acl.conf
echo 'acl BISA time WHFA 00:00-03:00' >> /etc/squid/acl.conf
sed -i '1i include /etc/squid/acl.conf' /etc/squid/squid.conf
service squid restart
