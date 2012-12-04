class puppet::puppetdb::service {
  Service {
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  service { 'puppetdb': }
}
