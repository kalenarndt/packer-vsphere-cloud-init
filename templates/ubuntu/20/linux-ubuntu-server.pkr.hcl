/*
    DESCRIPTION: 
    Ubuntu Server 20.04 LTS template using the Packer Builder for VMware vSphere (vsphere-iso).
*/

//  BLOCK: packer
//  The Packer configuration.

packer {
  required_version = ">=1.7.4"
  required_plugins {
    vsphere = {
      version = ">=v1.0.1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

//  BLOCK: locals
//  Defines the local variables.

locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

//  BLOCK: source
//  Defines the builder configuration blocks.

source "vsphere-iso" "linux-ubuntu-server" {

  // vCenter Server Endpoint Settings and Credentials
  vcenter_server      = var.vsphere_endpoint
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure_connection

  // vSphere Settings
  datacenter = var.vsphere_datacenter
  cluster    = var.vsphere_cluster
  datastore  = var.vsphere_datastore
  folder     = var.vsphere_folder

  // Virtual Machine Settings
  guest_os_type        = var.vm_guest_os_type
  vm_name              = "${var.vm_guest_os_family}-${var.vm_guest_os_vendor}-${var.vm_guest_os_member}-${var.vm_guest_os_version}"
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = var.vm_cpu_hot_add
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = var.vm_mem_hot_add
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = var.vm_disk_thin_provisioned
  }
  network_adapters {
    network      = var.vsphere_network
    network_card = var.vm_network_card
  }
  vm_version           = var.vsphere_vm_version
  remove_cdrom         = var.vsphere_remove_cdrom
  tools_upgrade_policy = var.vsphere_tools_upgrade_policy
  notes                = "Built by HashiCorp Packer on ${local.buildtime}."

  // Removable Media Settings
  #iso_paths    = ["[${var.vsphere_iso_datastore}] ${var.vsphere_iso_path}/${var.iso_file}"]
  iso_checksum = "${var.vsphere_iso_hash}:${var.iso_checksum}"
  iso_urls     = [var.iso_urls]

  // Boot and Provisioning Settings
  http_port_min = var.vsphere_http_port_min
  http_port_max = var.vsphere_http_port_max
  http_content = {
    "/meta-data" = file("data/meta-data")
    "/user-data" = templatefile("data/user-data.pkrtpl.hcl", { build_username = var.build_username, build_password_encrypted = var.build_password_encrypted, vm_guest_os_language = var.vm_guest_os_language, vm_guest_os_keyboard = var.vm_guest_os_keyboard, vm_guest_os_timezone = var.vm_guest_os_timezone, build_key = var.build_key })
  }
  boot_order = var.vm_boot_order
  boot_wait  = var.vm_boot_wait
  # Modified boot command from VMware's example repo https://github.com/vmware-samples/packer-examples-for-vsphere/blob/fe84fb98ef0743811ef1907851583434e8a21672/builds/linux/ubuntu/20-04-lts/linux-ubuntu.pkr.hcl#L95-L103
  boot_command = [
    "<esc><wait>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\"",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  ip_wait_timeout  = var.vsphere_ip_wait_timeout
  shutdown_command = "echo '${var.build_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = var.vsphere_shutdown_timeout

  // Communicator Settings and Credentials
  communicator           = "ssh"
  ssh_username           = var.build_username
  ssh_password           = var.build_password
  ssh_handshake_attempts = var.ssh_handshake_attempts
  ssh_port               = var.communicator_port
  ssh_timeout            = var.communicator_timeout

  // Template and Content Library Settings
  convert_to_template = var.vsphere_template_conversion
  #   content_library_destination {
  #     library = var.vsphere_content_library_name
  #     ovf     = var.vsphere_content_library_ovf
  #     destroy = var.vsphere_content_library_destroy
  #   }
}

//  BLOCK: build
//  Defines the builders to run, provisioners, and post-processors.

build {
  sources = ["source.vsphere-iso.linux-ubuntu-server"]

  provisioner "shell" {
    execute_command = "echo '${var.build_password}' | {{.Vars}} sudo -E -S sh -eux '{{.Path}}'"
    environment_vars = [
      "BUILD_USERNAME=${var.build_username}",
      "BUILD_KEY=${var.build_key}",

    ]
    scripts = var.scripts
  }

}