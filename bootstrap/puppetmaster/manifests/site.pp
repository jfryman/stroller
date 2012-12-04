# This is a temporary file while Vagrant Dev and
# current running Puppet are further merged together
# into one big happy family.

node basenode {
  include stdlib
  include ruby
}

node /puppetmaster/ inherits basenode {
  class { 'vagrant::hitch::load_dns': }

  class { 'bind': }

  bind::zone { $::domain:
    zone_serial    => '1',
    zone_refresh   => '604800',
    zone_retry     => '86400',
    zone_expire    => '2419200',
    zone_neg_cache => '604800',
    zone_ttl       => '3600000',
  }

  bind::ns { 'ns':
    zone => $::domain,
  }

  bind::record { 'ns':
    zone   => $::domain,
    target => $::ipaddress,
  }

  class { 'resolver::conf':
    domain_name => $::domain,
    nameservers => $::ipaddress,
    stage       => 'setup_infra',
  }

  # Install PuppetMaster
  class { 'puppet::server':
    master_certname => $::fqdn,
    dns_alt_names   => [
      '192.168.150.2',
      'puppetmaster',
      'puppet',
    ],
  }
  -> class { 'puppet::puppetdb': }
}
