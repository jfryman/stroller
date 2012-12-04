# Class for minimal Puppetmaster Install within Vagrant. Nothing fancy, nor up to any
# code quality. Just does the basics. Will incorporate with already-existing Puppet::Server
# directives once integration is complete.
class puppet::server::config(
  $agent_certname     = $::fqdn,
  $master_certname    = undef,
  $dns_alt_names      = undef,
  $puppetmaster       = undef,
  $puppet             = $puppet::params::defaults
) inherits puppet::params {
  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { "${puppet::params::defaults[root]}/fileserver.conf":
    ensure  => present,
    content => template('puppet/fileserver.conf.erb'),
  }
  file { "${puppet::params::defaults[root]}/autosign.conf":
    ensure  => present,
    content => '*',
  }
  file { "${puppet::params::defaults[root]}/auth.conf":
    ensure => present,
    source => 'puppet:///modules/puppet/auth.conf',
  }
  file { "${puppet::params::defaults[root]}/puppet.conf":
    ensure  => present,
    content => template(
      'puppet/main.conf.erb',
      'puppet/agent.conf.erb',
      'puppet/master.conf.erb'
    ),
  }

  file { '/etc/default/puppetmaster':
    ensure => present,
    mode   => '0644',
    source => 'puppet:///modules/puppet/puppetmaster.default',
  }

  file { [
    "${puppet::params::defaults[root]}/files",
    "${puppet::params::defaults[root]}",
  ]:
    ensure => directory,
  }

  file { "${puppet::params::defaults[ssldir]}":
    ensure => directory,
    owner  => 'puppet',
    mode   => '0771',
  }


  file { "${puppet::params::defaults[rundir]}":
    ensure => directory,
    mode   => '1777',
  }

  # Support Directories for Puppet
  file { $puppet::params::defaults[vardir]:
    ensure => directory,
    owner  => $puppet::params::defaults[user],
    group  => $puppet::params::defaults[user],
  }

  file { $puppet::params::defaults[logdir]:
    ensure => directory,
    owner  => $puppet::params::defaults[user],
    group  => $puppet::params::defaults[user],
    mode   => '0750',
  }

  user { $puppet::params::defaults[user]:
    ensure     => present,
    managehome => true,
  }

  group { $puppet::params::defaults[group]:
    ensure => present,
  }
}
