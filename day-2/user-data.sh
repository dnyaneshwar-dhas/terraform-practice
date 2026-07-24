#!/bin/bash
sudo dnf update
sudo dnf install httpd -y
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
sudo echo "<h1> welcome to Dnyanu terraform practice world </h1>" > /var/www/html/index.html 