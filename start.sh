#!/bin/bash

 ./max.txt
docker ps | grep httpd_con | awk '{print "docker cp ./id_rsa.pub "$1":/tmp/id_rsa.pub"}' > /tmp/_.sh
sh /tmp/_.sh
docker ps | grep httpd_con | awk '{print "docker exec -t "$1" sh /root/commands_httpd1.sh"}' > /tmp/_.sh
sh /tmp/_.sh
docker ps | grep httpd_con | awk '{print "docker exec -t "$1" sh /root/commandsGetipaddr.sh"}' > /tmp/_.sh
sh /tmp/_.sh > /tmp/ipaddrs.txt

ruby ip2ab_sh.rb < /tmp/ipaddrs.txt > /tmp/_.sh
rm -f _result_ab_*.txt
sh /tmp/_.sh
cat _result_ab_*.txt > ./_results_ab_$max.txt
ruby web_random_access_bench_1_08.rb /tmp/ipaddrs.txt > ./_results_web_rand_&max.txt

echo fin!
