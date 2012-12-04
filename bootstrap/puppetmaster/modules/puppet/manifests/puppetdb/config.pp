class puppet::puppetdb::config(
  $puppetdb = $puppet::params::puppetdb[defaults]
) inherits puppet::params {
  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  Exec {
    path => '/bin:/usr/bin:/sbin:/usr/sbin',
  }

  file { "${puppet::params::defaults[root]}/puppetdb.conf":
    ensure  => present,
    content => template('puppet/puppetdb.conf.erb'),
  }
  file { "${puppet::params::defaults[root]}/routes.yaml":
    ensure  => present,
    content => template('puppet/routes.yaml.erb'),
  }

  file { $puppet::params::puppetdb[defaults][root]:
    ensure => directory,
  }

  file { $puppet::params::puppetdb[defaults][ssldir]:
    ensure => directory,
  }
}
