class { 'postgresql::globals':
  manage_package_repo => true,
  version             => '8.4',
  # the 8.4 package puts these in places the module is not expecting
  # so we manually configure them to avoid provisioning errors
  datadir      => '/var/lib/pgsql/data',
  bindir       => '/usr/bin',
  service_name => 'postgresql',
}->
class { 'postgresql::server': }

postgresql::server::db { 'hippo':
  user => 'hippo',
  password => postgresql_password('hippo', 'hippo'),
  encoding => 'UNICODE',
}