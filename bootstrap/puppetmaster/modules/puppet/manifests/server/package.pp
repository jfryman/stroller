class puppet::server::package inherits puppet::params {
  package { $puppet::params::packages:
    ensure => present,
  }
  -> package { $puppet::params::gems:
    ensure   => present,
    provider => 'gem',
  }
  ->
  # Special Install of ActiveRecord 3.0.10 to
  # combat http://projects.puppetlabs.com/issues/9290
  # This also needs some work. God? -JDF (20121109)
  package { 'activerecord':
    ensure   => '3.0.10',
    provider => 'gem',
  }
}
