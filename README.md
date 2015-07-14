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
$ mvn -P separate-dist
$ cp target/*.tar.gz ../public-hippo-vagrant/dist
```

### Obtain an Oracle JDK

See the [Prerequisites section](#prerequisites) for instructions.

### Bring up the Vagrant and start Tomcats

The [hippo.sh](scripts/hippo.sh) provisioning script currently looks for
distribution tarballs for Hippo version 7.8.9. You can change that by setting the
`HIPPO_VERSION` environment variable before running `vagrant up`.

```
$ cd ../public-hippo-vagrant
$ vagrant up
# or use a different version of Hippo
$ HIPPO_VERSION=7.8.9-1 vagrant up
$ vagrant ssh
```

In the VM:

```
vagrant@localhost$ cd /apps/cms/tomcat-cms
vagrant@localhost$ ./control start
vagrant@localhost$ cd /apps/cms/tomcat-site
vagrant@localhost$ ./control start
```

You can watch the Tomcat log in a separate window by doing:

```
$ cd /apps/git/public-hippo-vagrant
# for the cms:
$ vagrant ssh -- tail -f /apps/cms/tomcat-cms/logs/catalina.out
# or for the site:
$ vagrant ssh -- tail -f /apps/cms/tomcat-site/logs/catalina.out
```

Once both Tomcats start up, you should have a functioning web application on the
following URLs:

* Site: <http://192.168.55.10:9700/site>
* CMS: <http://192.168.55.10:9600/cms>
* CMS Console: <http://192.168.55.10:9600/cms/console>

## Structure

* **[dist/](dist):** Holding area for tarballs used by the provisioner (JDK,
  Tomcat, etc.); these are not stored under version control
* **[env/](env):** Config files copied by the shell provisioner
  [scripts](scripts)
    * **[tomcat/](env/tomcat):** Configuration that is common between the CMS
      and Site Tomcats
    * **[tomcat-cms/](env/tomcat-cms):** CMS Tomcat-specific configuration
    * **[tomcat-site/](env/tomcat-site):** CMS Tomcat-specific configuration
* **[manifests/](manifests):** Puppet manifests for provisioning
* **[scripts/](scripts):** Shell scripts for provisioning
* **[Vagrantfile](Vagrantfile):** The Vagrantfile that controls it all

## Runtime Environment Structure

Within the **/apps/cms** directory on the VM, there is a parallel structure of 3
directories each for the CMS and the Site. These are:

* **tomcat-{cms,site}:** `CATALINA_BASE` directory containing the Tomcat runtime
  configuration files (including the repository.xml), the logs, and control
  script.
* **storage-{cms,site}:** Hippo local repository storage. Note that each
  instance needs its own storage directory, though they both use the same
  PostgreSQL database for persistance storage. This location is set using the
  `repo_path` environment variable in the
  **tomcat-{cms,site}/conf/env-config.properties** file.
* **webapps-{cms,site}:** Hippo webapps deployed from the distribution tarball.

In addition, there is one copy of the public utilities (e.g. the DBFinder loader
script). It is located at **/apps/cms/utilities**.
