/*
    DESCRIPTION: 
    Ubuntu Server 20.04 LTS  variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_language = "en_US"
vm_guest_os_keyboard = "us"
vm_guest_os_timezone = "UTC"
vm_guest_os_family   = "linux"
vm_guest_os_vendor   = "ubuntu"
vm_guest_os_member   = "server"
vm_guest_os_version  = "20-04-lts"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "ubuntu64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi"
vm_cdrom_type            = "sata"
vm_cpu_sockets           = 2
vm_cpu_cores             = 1
vm_cpu_hot_add           = false
vm_mem_size              = 2048
vm_mem_hot_add           = false
vm_disk_size             = 40960
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_file     = "ubuntu-20.04.4-live-server-amd64.iso"
iso_checksum = "353758585dce42a098944a5ffc8704bd6597b96e0b136342040292a11a8c1cb674e3f1cea97ff77135b3aa8eca939d765adeb49602ea72fa08f02ad898b3f073"
iso_urls     = "https://releases.ubuntu.com/20.04/ubuntu-20.04.4-live-server-amd64.iso"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "5s"

// Communicator Settings
communicator_port      = 22
communicator_timeout   = "30m"
ssh_handshake_attempts = "20"

// Provisioner Settings
scripts = ["./scripts/ubuntu/20/ubuntu-20-cloud-init.sh"]

inline = []