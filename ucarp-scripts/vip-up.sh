#!/bin/sh -x

ip addr add ${UCARP_VIRTUALADDRESS}/${UCARP_VIRTUALPREFIX} dev ${UCARP_INTERFACE}
ip route add $(netmask ${UCARP_VIRTUALADDRESS}/${UCARP_VIRTUALPREFIX}) dev eth0 
ip route add default via ${UCARP_VIRTUALGATEWAY}

exit 0
