#!/usr/bin/env bash

echo ">Initializing Packer!"
packer init templates/ubuntu/20

echo ">Let's get building!"
packer build -force \
-var-file=templates/build.pkrvars.hcl \
-var-file=templates/vsphere.pkrvars.hcl \
 templates/ubuntu/20 | tee logs/packer_ubuntu_base_output.txt
