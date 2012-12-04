# This is a temporary file while Vagrant Dev and
# current running Puppet are further merged together
# into one big happy family.

node basenode {
  include stdlib
  include ruby
}

node /puppetmaster/ inherits basenode {
  $default_zone = 'github.com'

  class { 'vagrant::hitch::load_dns': }

  class { 'bind': }

  bind::zone { $default_zone:
    zone_serial    => '1',
    zone_refresh   => '604800',
    zone_retry     => '86400',
    zone_expire    => '2419200',
    zone_neg_cache => '604800',
    zone_ttl       => '3600000',
  }

  bind::ns { 'ns':
    zone => $default_zone,
  }

  bind::record { 'ns':
    zone   => $default_zone,
    target => $::ipaddress,
  }

  class { 'resolver::conf':
    domain_name => $default_zone,
    nameservers => $::ipaddress,
    stage       => 'setup_infra',
  }

  # Install PuppetMaster
  class { 'puppet::server':
    master_certname => 'puppetmaster',
    dns_alt_names   => [
      '192.168.150.2',
      'puppetmaster',
      'puppet',
    ],
  }
  -> class { 'puppet::puppetdb': }
}
