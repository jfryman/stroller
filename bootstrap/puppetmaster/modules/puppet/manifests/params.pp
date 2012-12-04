class puppet::params {
  $defaults = {
    root   => '/etc/puppet',
    vardir => '/var/lib/puppet',
    logdir => '/var/lib/puppet/log',
    rundir => '/var/lib/puppet/run',
    ssldir => '/var/lib/puppet/ssl',
    user   => 'puppet',
    group  => 'puppet',
  }

  $puppet = {
    version  => '2.7.18-1puppetlabs1',
    packages => [
      'puppetmaster-common',
      'puppetmaster',
      'puppet',
      'puppet-common',
    ]
  }

  $puppetdb = {
    version  => 'latest',
    packages => [
      'puppetdb',
      'puppetdb-terminus'
    ],
    defaults => {
      root   => '/etc/puppetdb',
      ssldir => '/etc/puppetdb/ssl',
    }
  }

  $packages = [
    'libsqlite3-dev',
    'libaugeas-ruby1.8',
    'build-essential'
  ]
}
