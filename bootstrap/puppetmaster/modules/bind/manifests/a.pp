# = Define: bind::a
#
# Create a A DNS record.
# See bind::record for more informations
#
# == Examples:
#
# bind::a { 'www':
#   zone   => 'example42.com',
#   target => '42.42.42.42',
# }
#
# bind::a { 'www':
#   zone   => 'example42.com',
#   target => '42.42.42.42',
#   absent => true,
# }
#
# bind::a { 'web-server':
#   zone   => 'example42.com',
#   target => '42.42.42.42',
#   host   => 'www',
#   ttl    => 10000,
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
define bind::a (
  $zone,
  $target,
  $host         = $name,
  $record_class = 'IN',
  $export_tag   = $zone,
  $absent       = false,
  $template     = 'bind/record.erb',
  $ttl          = '',
  $order        = '40',
  ) {

  bind::record { "A-$name":
    zone         => $zone,
    target       => $target,
    host         => $host,
    record_type  => 'A',
    record_class => $record_class,
    export_tag   => $export_tag,
    absent       => $absent,
    template     => $template,
    ttl          => $ttl,
    order        => $order,
  }
}
