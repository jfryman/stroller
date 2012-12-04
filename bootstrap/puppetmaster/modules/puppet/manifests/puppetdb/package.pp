class puppet::puppetdb::package(
  $puppetdb_version = $puppet::params::puppetdb['version']
) inherits puppet::params {
  package { $puppet::params::puppetdb['packages']:
    ensure => $puppetdb_version,
  }
}
