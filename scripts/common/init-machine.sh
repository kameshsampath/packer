#!/bin/bash -evux

# enable epel repo

sudo rpm -ivh http://epel.mirror.net.in/epel/6/i386/epel-release-6-8.noarch.rpm

# Sudoers update
sudo sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=vagrant' /etc/sudoers

# Automatically generate the key:
 mkdir /home/vagrant/.ssh

# Add the public key to /home/vagrant/.ssh/authorized_keys
 
 cat /tmp/workspace7-vagrant.pub >>  /home/vagrant/.ssh/authorized_keys

 chown -R vagrant /home/vagrant/.ssh
 chmod -R go-rwsx /home/vagrant/.ssh


#SSH configurations
 sudo sed -i -e '$ a\ UseDNS no' /etc/ssh/sshd_config
 sudo sed -i -e 's/#GSSAPIAuthentication no/GSSAPIAuthentication no/' /etc/ssh/sshd_config
 sudo sed -i -e 's/GSSAPIAuthentication yes/#GSSAPIAuthentication yes/' /etc/ssh/sshd_config

#Install Chef

if [ "x$chef_installer_url" != "x" ]; then 
   curl -L --retry 5 --retry-delay 10  $chef_installer_url | sudo bash 
fi

# Slow DNS fix
 sudo sed -i  -e '$ a\ RES_OPTIONS=\"single-request-reopen\"' /etc/sysconfig/network
 sudo service network restart

