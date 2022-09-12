#!/bin/bash

yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Welcome to the RED TEAM page!" > /var/www/html/index.html