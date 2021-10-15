#!/bin/bash
# Maintainer: k@kalen.sh
# Pulls the Consul Demo Apps

wget https://github.com/hashicorp/demo-consul-101/releases/download/0.0.3.1/counting-service_linux_amd64.zip
wget https://github.com/hashicorp/demo-consul-101/releases/download/0.0.3.1/dashboard-service_linux_amd64.zip
unzip counting-service_linux_amd64.zip -d /home/packer/
unzip dashboard-service_linux_amd64.zip -d /home/packer/
chmod +x counting-service_linux_amd64 
chmod +x dashboard-service_linux_amd64