#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install nano
apt-get install isc-dhcp-server -y
sed -i '$ d' /etc/default/isc-dhcp-server
echo -e 'INTERFACES="eth0"' >> /etc/default/isc-dhcp-server
echo 'subnet 10.47.2.0  netmask 255.255.255.0{
}

subnet 10.47.1.0 netmask 255.255.255.0 {
    range 10.47.1.20 10.47.1.99;
    range 10.47.1.150 10.47.1.169;
    option routers 10.47.1.1;
    option broadcast-address 10.47.1.255;
    option domain-name-servers 10.47.2.2;
    default-lease-time 360;
    max-lease-time 7200;
}
subnet 10.47.3.0 netmask 255.255.255.0 {
    range 10.47.3.30 10.47.3.50;
    option routers 10.47.3.1;
    option broadcast-address 10.47.3.255;
    option domain-name-servers 10.47.2.2;
    default-lease-time 720;
    max-lease-time 7200;
}
host Skypie {
    hardware ethernet ae:4b:ec:5d:15:4d;
    fixed-address 10.47.3.69;
}' >> /etc/dhcp/dhcpd.conf
service isc-dhcp-server restart
service isc-dhcp-server status
