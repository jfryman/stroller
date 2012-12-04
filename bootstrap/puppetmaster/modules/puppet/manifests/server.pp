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

  Class['puppet::repository']
  -> anchor{ 'puppet::server::begin': }
  -> class { 'puppet::server::package': }
  -> class { 'puppet::server::config':
    agent_certname   => $agent_certname,
    master_certname  => $master_certname,
    dns_alt_names    => $dns_alt_names,
    puppetmaster     => $puppetmaster,
  }
  ~> class { 'puppet::server::service': }
  -> anchor{ 'puppet::server::end': }
}
