# Class for minimal Puppetmaster Install within Vagrant. Nothing fancy, nor up to any
# code quality. Just does the basics. Will incorporate with already-existing Puppet::Server
# directives once integration is complete.
class puppet::server(
  $agent_certname   = $::fqdn,
  $master_certname  = undef,
  $dns_alt_names    = undef,
  $puppetmaster     = undef
) {
  include puppet

  anchor { ['puppet::server::begin', 'puppet::server::end']: }

  class { 'puppet::server::package': }
  class { 'puppet::server::config':
    agent_certname   => $agent_certname,
    master_certname  => $master_certname,
    dns_alt_names    => $dns_alt_names,
    puppetmaster     => $puppetmaster,
  }
  class { 'puppet::server::service': }

  # We do some weird ordering here for several reasons
  # 1) Puppet packages like to start services after they're installed, 
  #    which has a tendency to break some things here. So, get the config
  #    onto the system prior to packages.
  # 2) Any changes to the Puppet::Server::Class should refresh the Puppet Master
  # 3) Anchoring makes everything fun!
  Class['puppet::repository']
  -> Anchor['puppet::server::begin']
  -> Class['puppet::server::config']
  -> Class['puppet::server::package']

  Class['puppet::server::config'] 
  ~> Class['puppet::server::service']

  Class['puppet::server::package']
  -> Class['puppet::server::service']
  -> Anchor['puppet::server::end']
}
