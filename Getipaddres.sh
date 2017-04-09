#!/bin/bash

docker ps | grep httpd_con | awk '{print "docker exec -t "$1" sh /root/commandsGetipaddr.sh"}' > /tmp/_.sh
sh /tmp/_.sh > /tmp/ipaddrs.txt
