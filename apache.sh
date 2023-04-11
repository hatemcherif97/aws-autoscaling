#!/bin/bash
sudo yum update -y &&
sudo yum install -y httpd &&
systemctl start httpd
systemctl enable httpd

cd /var/www/html
sudo echo "<html><body><h1>Welcome to my Apache webpage!</h1></body></html>" > /var/www/html/index.html
