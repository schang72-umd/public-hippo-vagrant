#!/bin/bash

mkdir -p /apps/cms/storage-{cms,site}/workspaces
cp -rpv /vagrant/env/tomcat /apps/cms/tomcat-cms
cp -rpv /vagrant/env/tomcat /apps/cms/tomcat-site
cp -rpv /vagrant/env/tomcat-{cms,site} /apps/cms
# directories needed by Tomcat
mkdir -p /apps/cms/tomcat-{cms,site}/{logs,temp}
