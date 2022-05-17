#!/bin/bash
# Maintainer: kalen@kalen.sh
# Prepares a Ubuntu Server guest operating system.

cat << 'EOL' | sudo tee /etc/rc.local
#!/bin/sh -ef
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
# dynamically create hostname (optional)
if hostname | grep localhost; then
    hostnamectl set-hostname "$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')"
fi
test -f /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure openssh-server
exit 0
EOL

# make sure the script is executable
chmod +x /etc/rc.local

# Ignore VMware Devices - This causes issues in multipathd where it just keeps attempting to add paths for the attached disks and floods the logs
cat <<EOF >> /etc/multipath.conf
blacklist {
    device {
        vendor "VMware"
        product "Virtual disk"
    }
}
EOF

### Create a cleanup script. ###
echo '> Creating cleanup script ...'
sudo cat <<EOF > /tmp/cleanup.sh
#!/bin/bash

# Cleans all audit logs.
echo '> Cleaning all audit logs ...'
if [ -f /var/log/audit/audit.log ]; then
cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
cat /dev/null > /var/log/lastlog
fi

# Cleans persistent udev rules
echo '> Cleaning persistent udev rules'
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
rm /etc/udev/rules.d/70-persistent-net.rules
fi

# Cleans /tmp directories
echo '> Cleaning /tmp directories'
rm -rf /tmp/*
rm -rf /var/tmp/*

# Cleans SSH keys
echo '> Cleaning SSH keys'
rm -f /etc/ssh/ssh_host_*

# Sets hostname to localhost
echo '> Setting hostname to localhost'
cat /dev/null > /etc/hostname
hostnamectl set-hostname localhost

# Cleans the machine-id.
echo '> Cleaning the machine-id'
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Cleans shell history.
echo '> Cleaning shell history'
unset HISTFILE
history -cw
echo > ~/.bash_history
rm -fr /root/.bash_history

# Cloud-Init Options
rm -rf /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg
rm -rf /etc/cloud/cloud.cfg.d/99-installer.cfg
rm -rf /etc/netplan/00-installer-config.yaml
echo "disable_vmware_customization: false" >> /etc/cloud/cloud.cfg
echo "datasource_list: [ VMware, OVF, None ]" > /etc/cloud/cloud.cfg.d/90_dpkg.cfg

# Set boot options to not override what we are sending in cloud-init
echo `> Modifying GRUB`
sed -i -e "s/GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"/GRUB_CMDLINE_LINUX_DEFAULT=\"\"/" /etc/default/grub
update-grub
EOF

### Change script permissions for execution. ### 
echo '> Changing script permissions for execution ...'
sudo chmod +x /tmp/cleanup.sh


### Executes the cleauup script. ### 
echo '> Executing the cleanup script ...'
sudo /tmp/cleanup.sh

### All done. ### 
echo '> Done.'  
