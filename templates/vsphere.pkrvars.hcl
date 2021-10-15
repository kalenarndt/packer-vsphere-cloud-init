/*
    DESCRIPTION: 
    VMaware vSphere variables used for all builds.
    - Variables are use by the source blocks.
*/

// vSphere Credentials
vsphere_endpoint            = "vc.bmrf.io"
vsphere_username            = "administrator@vsphere.local"
vsphere_password            = "VMware123!"
vsphere_insecure_connection = true

// vSphere Settings
vsphere_datacenter = "Black Mesa"
vsphere_cluster    = "Compute"
vsphere_datastore  = "ESXi2-SSD"
vsphere_network    = "Management-VL11"
vsphere_folder     = "templates/packer/ubuntu"


// Virtual Machine Settings
vsphere_vm_version           = 19
vsphere_tools_upgrade_policy = true
vsphere_remove_cdrom         = true

// Removable Media Settings
# vsphere_iso_datastore = "sfo-w01-cl01-ds-nfs01"
# vsphere_iso_path      = "iso"
vsphere_iso_hash = "sha512"

// Boot and Provisioning Settings
vsphere_http_port_min    = 8000
vsphere_http_port_max    = 8099
vsphere_ip_wait_timeout  = "20m"
vsphere_shutdown_timeout = "15m"

// Template and Content Library Settings
vsphere_template_conversion = true
# vsphere_content_library_name    = "sfo-w01-lib01"
# vsphere_content_library_ovf     = true
# vsphere_content_library_destroy = true