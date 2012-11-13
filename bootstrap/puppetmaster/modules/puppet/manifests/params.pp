class puppet::params {
  $defaults = {
    root   => '/etc/puppet',
    vardir => '/var/lib/puppet',
    logdir => '/var/lib/puppet/log',
    rundir => '/var/lib/puppet/run',
    ssldir => '/etc/puppet/ssl',
    user   => 'puppet',
    group  => 'puppet',
  }

  $gems = [
    'puppet',
    'sqlite3',
    'activerecord-jdbcsqlite3-adapter',
  ]

  $packages = [
    'libsqlite3-dev',
    'libaugeas-ruby1.8',
    'build-essential'
  ]
}
