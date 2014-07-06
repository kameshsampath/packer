#!/bin/bash -evux

# Setup MariaDB repo
sudo cp /tmp/mariadb.repo /etc/yum.repos.d

sudo yum --enablerepo=epel -y update

# MariaDB signature verification

sudo rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB

# Install Mariadb
sudo yum --enablerepo=epel -y install MariaDB-Galera-server MariaDB-client galera
