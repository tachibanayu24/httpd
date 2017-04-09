#!/bin/bash

. ./max.txt
for ((i=0; i < $max; i++)); do
	docker run -itd --privileged -p 3000:30000 --name httpd_cont$max tachibanayu24/centos7:exp3
done

