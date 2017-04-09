#!/bin/bash

 rm -f /tmp/_.sh
 for((i=0; i<64; i++));do
 docker ps | grep httpd_cont$i | awk '{print "docker exec -t "$1" service httpd restart"}' >> /tmp/_.sh
 done
 sh /tmp/_.sh
