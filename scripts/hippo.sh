#!/bin/bash

# deploy Hippo from dist tarballs
HIPPO_VERSION=7.8.8-3.2
HIPPO_DIST=/vagrant/dist/public-${HIPPO_VERSION}-distribution.tar.gz
HIPPO_SERVER_DIST=/vagrant/dist/public-${HIPPO_VERSION}-server-distribution.tar.gz

tar xvzf "$HIPPO_DIST" --directory /apps/cms/tomcat common conf shared
tar xvzf "$HIPPO_SERVER_DIST" --directory /apps/cms

# need the Postgres JDBC
PGSQL_JDBC_VERSION=8.4-702.jdbc4
PGSQL_JDBC=/vagrant/dist/postgresql-${PGSQL_JDBC_VERSION}.jar
if [ ! -e "$PGSQL_JDBC" ]; then
    PGSQL_JDBC_URL=https://jdbc.postgresql.org/download/postgresql-${PGSQL_JDBC_VERSION}.jar
    curl -Lso "$PGSQL_JDBC" "$PGSQL_JDBC_URL"
fi
cp "$PGSQL_JDBC" /apps/cms/tomcat/common/lib

sed -i "s/hippo.version=.*/hippo.version=$HIPPO_VERSION/" \
    /apps/cms/tomcat/conf/catalina.properties
