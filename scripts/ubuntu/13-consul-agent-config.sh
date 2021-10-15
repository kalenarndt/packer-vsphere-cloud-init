#!/bin/bash
# Maintainer: k@kalen.sh
# Prepares packer template as a consul agent.

# Wipe Consul config 
truncate -s 0 /etc/consul.d/consul.hcl 

# Set Consul Config 
tee /etc/consul.d/consul.hcl >/dev/null <<EOL
datacenter = "bmrf-sa"
data_dir = "/etc/consul.d/data"
client_addr = "0.0.0.0"

# Consul Connect
connect = {
  enabled = true
}

# Performance
performance = {
  raft_multiplier = 1
}

# Syslog
enable_syslog = true
log_level = "info"

server = false
retry_join = ["consul01.bmrf.io", "consul02.bmrf.io", "consul03.bmrf.io"]
EOL

# Set directory permissions
chown --recursive consul:consul /etc/consul.d 

# Enable Consul service
systemctl enable consul
