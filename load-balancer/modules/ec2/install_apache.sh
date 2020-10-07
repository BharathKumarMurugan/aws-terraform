#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2
echo "<center><h2>Deployed Apache2 via Terraform</h2></center>" > /var/www/html/index.html
