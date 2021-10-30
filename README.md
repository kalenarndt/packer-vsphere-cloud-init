
# Packer vSphere Cloud-Init

This repo contains templates that are specifically configured to be built with HashiCorp Packer and utilize Cloud-Init as the customization engine on VMware vSphere




## Requirements

* [HashiCorp Packer 1.78](https://www.packer.io/downloads)
* mkpasswd
    * Ubuntu - `apt install whois`
* Internet Connection - Packer will download the Ubuntu ISO from the internet
## Usage/Examples
#### Build Credentials
1. Generate your SSH keys by running `create-ssh-keys.sh`
2. Copy the contents of the `packer.pub` file 
3. Paste the contents on line 12 of [templates/build.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/build.pkrvars.hcl#L12)
4. Edit the `build_username` on line 9 of [templates/build.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/build.pkrvars.hcl#L9)
5. Edit the `build_password` on line 10 of [templates/build.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/build.pkrvars.hcl#L10)
6. In a linux terminal run `mkpasswd -m sha-512` and enter your desired password
7. Copy the output and edit the `build_password_encrypted` on line 11 of [templates/build.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/build.pkrvars.hcl#L11)

#### vSphere Credentials
1. Edit the `vsphere_endpoint` variable on line 8 of [templates/vsphere.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/vsphere.pkrvars.hcl#L8)
2. Edit the `vsphere_username` variable on line 9 of [templates/vsphere.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/vsphere.pkrvars.hcl#L9)
3. Edit the `vsphere_password` variable on line 10 of [templates/vsphere.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/vsphere.pkrvars.hcl#L10)

#### vSphere Settings
1. Edit the `vsphere_datacenter` variable on line 14 of [templates/vsphere.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/vsphere.pkrvars.hcl#L14)
2. Edit the `vsphere_cluster` variable on line 15 of [templates/vsphere.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/vsphere.pkrvars.hcl#L15)
3. Edit the `vsphere_datastore` variable on line 16 of [templates/vsphere.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/vsphere.pkrvars.hcl#L16)
4. Edit the `vsphere_network` variable on line 17 of [templates/vsphere.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/vsphere.pkrvars.hcl#L17)
5. Edit the `vsphere_folder` variable on line 18 of [templates/vsphere.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/vsphere.pkrvars.hcl#L18) If these folders don't exist, Packer will create them.

#### Virtual Machine Settings
1. Edit the `vsphere_vm_version` variable on line 22 of [templates/vsphere.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/vsphere.pkrvars.hcl#L22) to match the version your environment supports

#### Run
1. Run `build-ubuntu-20.sh`


## FAQ

#### I'm getting an error when Packer runs saying it can't find the ISO

- This Packer setup downloads the Ubuntu Server ISO from a pre-determined URL located in [templates/ubuntu/20/linux-ubuntu-server.auto.pkrvars.hcl](https://github.com/kalenarndt/packer-vsphere-cloud-init/blob/7a69eb201ba391d7d80e0baa9cd3f9f62877f41f/templates/ubuntu/20/linux-ubuntu-server.auto.pkrvars.hcl#L31)
- You can change the URL to something else or a newer release and re-run Packer
- Packer may throw an error for a checksum mismatch and if it does you can copy the new value output via the terminal to the config file so that they match


## Acknowledgements

 - [Rainpole Packer Templates for vSphere](https://github.com/rainpole/packer-vsphere)
 - [Grant Orchard's Blog](https://grantorchard.com/terraform-vsphere-cloud-init/)


## Roadmap

- Add dynamic fetching of public ssh key during build instead of manually requiring variable changes in build.hcl

- Add additional distro's
    - CentOS


