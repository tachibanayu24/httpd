#!/bin/bash

service sshd restart
cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys
rm -f /tmp/id_rsa.pub
service httpd restart
echo hello > /var/www/html/index.html
