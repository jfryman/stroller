class puppet::server::service {
  Service {
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  service { 'puppetmaster': }
}
