#!/bin/bash

for((i=0; i>64; i++));do
	docker ps | grep httpd_cont$i | awk '{print ""$1""}' >> /root/httpd/id.txt
done

