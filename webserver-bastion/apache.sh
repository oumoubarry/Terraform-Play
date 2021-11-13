#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1> Cloud Engineering is Amazing with Terraform!!! said Oumou <h1>" | sudo tee /var/www/html/index.html
