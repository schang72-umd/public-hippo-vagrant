# public-hippo-vagrant

HippoCMS development Vagrant environment

## Prerequisites

- VirtualBox
- Vagrant
- Oracle JDK 7 tar.gz (to be installed into the VM)
- [Hippo source code](https://github.com/umd-lib/public-hippo)

Due to the need to manually click through Oracle's license agreement in order to
download a JDK, the JDK is not automatically fetched by the provisioning
scripts. Instead, manually download a tar.gz distribution for 64-bit Linux from
[Oracle's site](http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html)
and place it in a `dist/` subdirectory of the `public-hippo-vagrant` checkout
directory.

The bootstrap provisioning script will pick up any `jdk-*.tar.gz` file, but note
that production is currently using Java 7u71, so that is the recommended version
to use for local development.

## Usage

### Check out the Vagrant

```
$ cd /apps/git
$ git clone git@github.com:umd-lib/public-hippo-vagrant.git
```

### Check out and compile the Hippo webapps

**Note:** the UMD public-hippo repository is private.

```
$ git clone git@github.com:umd-lib/public-hippo.git
$ cd public-hippo
$ mvn clean install
$ mvn -P server-dist
$ mvn -P dist
$ cp target/*.tar.gz ../public-hippo-vagrant/dist
```

### Obtain an Oracle JDK

See the [Prerequisites section](#prerequisites) for instructions.

### Bring up the Vagrant and start Tomcat

```
$ cd ../public-hippo-vagrant
$ vagrant up
$ vagrant ssh

vagrant@localhost$ cd /apps/cms/tomcat
vagrant@localhost$ ./control start
```

You can watch the Tomcat log in a separate window by doing:

```
$ cd /apps/git/public-hippo-vagrant
$ vagrant ssh -- tail -f /apps/cms/tomcat/logs/catalina.out
```

Once Tomcat starts up, you should have a functioning web application on the
following URLs:

* Site: <http://192.168.55.10:9600>
* CMS: <http://192.168.55.10:9600>
