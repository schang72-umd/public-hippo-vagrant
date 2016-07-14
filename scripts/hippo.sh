#!/bin/bash

# Deploys the HippoCMS distribution tarballs.
# Usage: hippo.sh [version]

# need the Postgres JDBC
PGSQL_JDBC_VERSION=8.4-702.jdbc4
PGSQL_JDBC=/vagrant/dist/postgresql-${PGSQL_JDBC_VERSION}.jar
if [ ! -e "$PGSQL_JDBC" ]; then
    PGSQL_JDBC_URL=https://jdbc.postgresql.org/download/postgresql-${PGSQL_JDBC_VERSION}.jar
    curl -Lso "$PGSQL_JDBC" "$PGSQL_JDBC_URL"
fi

# deploy Hippo from dist tarballs
HIPPO_VERSION=${1:-7.8.9}

for APP in cms site site2; do
    HIPPO_DIST=/vagrant/dist/public-${HIPPO_VERSION}-${APP}-distribution.tar.gz
    # webapps and utilities
    if [ "$APP" != "site2" ]; then
      tar xvzf "$HIPPO_DIST" --directory /apps/cms webapps utilities
    fi
    # per-Tomcat runtime common and shared libs
    tar xvzf "$HIPPO_DIST" --directory /apps/cms/tomcat-${APP} common shared

    sed -i "s/hippo.version=.*/hippo.version=$HIPPO_VERSION/" \
        /apps/cms/tomcat-${APP}/conf/catalina.properties
    cp "$PGSQL_JDBC" /apps/cms/tomcat-${APP}/common/lib
done

# copy utilities property file
UTILITIES_PROPERTIES=/vagrant/env/.public-utilities.properties
cp "$UTILITIES_PROPERTIES" /home/vagrant
