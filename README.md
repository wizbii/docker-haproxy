# Docker http endpoint

A docker image with haproxy, ucarp and some other tools (netmask, iptables).

## Ucarp

Ucarp is configurable through environement.
Use either with `--net=host` or with a MacVlan docker network.

## Haproxy

Haproxy is configurable by bind mounting a `haproxy.cfg`. Use like this:`-v $path_to_haproxy.cfg:/etc/haproxy/haproxy.cfg`

