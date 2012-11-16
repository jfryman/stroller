class resolver::conf(
  $ensure      = present,
  $domain_name = undef,
  $search_path = undef,
  $nameservers = undef,
) {

  if !$nameservers {
    fail('Must define nameservers')
  }

  file { '/etc/resolv.conf':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('resolver/resolv.conf.erb'),
  }
}
