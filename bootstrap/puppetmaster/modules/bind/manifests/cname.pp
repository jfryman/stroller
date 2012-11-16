# = Define: bind::cname
#
# Create a CNAME DNS record.
# See bind::record for more informations
#
# == Examples:
#
# bind::cname { 'www':
#   zone    => 'example42.com',
#   target  => 'my-host',
# }
#
# bind::cname { 'www':
#   zone    => 'example42.com',
#   target  => 'my-host',
#   absent  => true,
# }
#
# == Authors
#
# Romain THERRAT <romain42@gmail.com>
#
# Based on Example42 rules
# Alessandro Franceschi <al@lab42.it/>
#
# == Copyright
#
# Released under the terms of Apache2 licence.
#
define bind::cname (
  $zone,
  $target,
  $host         = $name,
  $record_class = 'IN',
  $export_tag   = $zone,
  $absent       = false,
  $template     = 'bind/record.erb',
  $ttl          = '',
  $order        = '60'
  ) {

  bind::record { "CNAME-$name":
    zone         => $zone,
    target       => $target,
    host         => $host,
    record_type  => 'CNAME',
    record_class => $record_class,
    export_tag   => $export_tag,
    absent       => $absent,
    template     => $template,
    ttl          => $ttl,
    order        => $order,
  }
}
