#!/bin/bash

yum -y install openssh-server
service sshd restart

mkdir /root/.ssh/
chmod 700 /root/.ssh/
touch /root/.ssh/authorized_keys
chomod 600 /root/.ssh/authorized_keys

yum -y install httpd
service httpd restart
