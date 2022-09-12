#!/bin/bash

sudo yum update -y
sudo install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
echo “<html><body><h1>"Welcome to the RED TEAM test page!</h1></body></html>” > /var/www/html/index.html