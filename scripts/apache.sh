#!/bin/bash

# First install mod_jk
sudo rpm -Uvh /vagrant/dist/apache2-mod_jk-1.2.37-4.1.x86_64.rpm

# Create the apache directory
cd /apps/cms
tar -zxvf /vagrant/env/apache.tgz

# Modify the apachectl executables.
cd /apps/cms/apache/bin
sudo chown root:vagrant apachectl
sudo chown root:root apachectl.exec
sudo chmod 4750 apachectl

