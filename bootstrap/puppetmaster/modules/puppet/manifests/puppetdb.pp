class puppet::puppetdb {
  include puppet

  Class['puppet::repository']
  -> anchor{ 'puppet::puppetdb::begin': }
  -> class { 'puppet::puppetdb::package': }
  -> class { 'puppet::puppetdb::config': }
  ~> class { 'puppet::puppetdb::service': }
  -> anchor{ 'puppet::puppetdb::end': }
}
