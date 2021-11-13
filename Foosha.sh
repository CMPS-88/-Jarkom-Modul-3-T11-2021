#!/bin/bash

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.47.0.0/16
apt-get install nano -y
apt-get install isc-dhcp-relay -y
echo '# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="10.47.2.4"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth1 eth3 eth2"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""' > /etc/default/isc-dhcp-relay
/etc/init.d/isc-dhcp-relay restart
