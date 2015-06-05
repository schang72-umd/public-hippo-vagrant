# public-hippo-vagrant

HippoCMS development Vagrant environment

## Prerequisites

- VirtualBox
- Vagrant
- Oracle JDK 7 tar.gz (to be installed into the VM)

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

```
$ git clone git@github.com:umd-lib/public-hippo-vagrant.git
$ cd public-hippo-vagrant
$ vagrant up
```
