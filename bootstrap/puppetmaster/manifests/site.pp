# This is a temporary file while Vagrant Dev and
# current running Puppet are further merged together
# into one big happy family.

node basenode {

}

node /puppetmaster/ inherits basenode {
  class { 'vagrant::hitch::load_dns': }

  class { 'puppet::server':
    master_certname => 'puppetmaster',
    dns_alt_names   => [
      '192.168.200.2',
      'puppetmaster',
      'puppet',
    ],
  }
}
