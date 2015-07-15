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

firewall { '100 allow http access to tomcat-cms':
  port => [9600, 9603, 9604, 9605],
  proto => tcp,
  action => accept,
}
firewall { '110 allow http access to tomcat-site':
  port => [9700, 9703, 9704, 9705],
  proto => tcp,
  action => accept,
}
