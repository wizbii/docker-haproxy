#!/bin/sh -x

ip route del default
ip route del ${UCARP_VIRTUALGATEWAY}/${UCARP_VIRTUALPREFIX}
ip addr del ${UCARP_VIRTUALADDRESS}/${UCARP_VIRTUALPREFIX} dev ${UCARP_INTERFACE}

exit 0
