#!/bin/bash

mkdir -p /apps/cms/storage-{cms,site,site2}/workspaces
cp -rpv /vagrant/env/tomcat /apps/cms/tomcat-cms
cp -rpv /vagrant/env/tomcat /apps/cms/tomcat-site
cp -rpv /vagrant/env/tomcat /apps/cms/tomcat-site2
cp -rpv /vagrant/env/tomcat-{cms,site,site2} /apps/cms
# directories needed by Tomcat
mkdir -p /apps/cms/tomcat-{cms,site,site2}/{logs,temp}
