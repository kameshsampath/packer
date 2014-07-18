#!/bin/bash -evux

# Sudoers update
sudo sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=vagrant' /etc/sudoers

# Automatically generate the key:
 mkdir /home/vagrant/.ssh

# Add the public key to /home/vagrant/.ssh/authorized_keys
 
wget --no-check-certificate \
    'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' \
    -O /home/vagrant/.ssh/authorized_keys

chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh


#SSH configurations
sudo sed -i -e '$ a\ UseDNS no' /etc/ssh/sshd_config
sudo sed -i -e 's/#GSSAPIAuthentication no/GSSAPIAuthentication no/' /etc/ssh/sshd_config
sudo sed -i -e 's/GSSAPIAuthentication yes/#GSSAPIAuthentication yes/' /etc/ssh/sshd_config

# Slow DNS fix
sudo sed -i  -e '$ a\ RES_OPTIONS=\"single-request-reopen\"' /etc/sysconfig/network
sudo service network restart

