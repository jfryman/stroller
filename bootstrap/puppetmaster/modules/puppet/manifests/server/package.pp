class puppet::server::package(
  $puppet_version = $puppet::params::puppet['version']
) inherits puppet::params {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  package { $puppet::params::puppet['packages']:
    ensure => $puppet_version,
  }
}
