#!/bin/bash
# Maintainer: k@kalen.sh
# Prepares packer template as a consul agent.


### Create Dashboard Service for automatic service registration ###
tee /etc/consul.d/dashboard.hcl > /dev/null <<EOL
service {
  name = "counting"
  port = 9003

  connect {
    sidecar_service {}
  }

  check {
    id       = "counting-check"
    http     = "http://localhost:9003/health"
    method   = "GET"
    interval = "1s"
    timeout  = "1s"
  }
}
EOL

### Set directory permissions ##
chown --recursive consul:consul /etc/consul.d 