class puppet::server::service {
  service { 'puppetmaster':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
