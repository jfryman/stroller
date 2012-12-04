class puppet::server::package(
  $puppet_version = $puppet::params::puppet['version']
) inherits puppet::params {

  package { $puppet::params::puppet['packages']:
    ensure => $puppet_version,
  }
}
