#!/bin/bash
# Maintainer: k@kalen.sh
# Prepares packer template as a consul agent.


### Create Dashboard Service for automatic service registration ###
tee /etc/consul.d/dashboard.hcl > /dev/null <<EOL
service {
  name = "dashboard"
  port = 9002

  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "counting"
            local_bind_port  = 5000
          }
        ]
      }
    }
  }

  check {
    id       = "dashboard-check"
    http     = "http://localhost:9002/health"
    method   = "GET"
    interval = "1s"
    timeout  = "1s"
  }
}
EOL

# Set directory permissions ###
chown --recursive consul:consul /etc/consul.d 