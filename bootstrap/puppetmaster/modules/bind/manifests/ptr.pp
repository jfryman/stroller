# = Define: bind::ptr
#
# Create a PTR DNS record.
# See bind::record for more informations
#
# == Examples:
#
# bind::ptr { '42':
#   zone   => '42.42.10.IN-ADDR.ARPA',
#   target => 'the-server.example42.com',
# }
#
# If you want to remove a PTR record
#
# bind::ptr { '42':
#   zone   => '42.42.10.IN-ADDR.ARPA',
#   target => 'the-server.example42.com',
#   absent => true,
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
define bind::ptr (
  $zone,
  $target,
  $host         = $name,
  $record_class = 'IN',
  $export_tag   = $zone,
  $absent       = false,
  $template     = 'bind/record.erb',
  $ttl          = '',
  $order        = '70'
  ) {

  bind::record { "PTR-$name":
    zone         => $zone,
    target       => $target,
    host         => $host,
    record_type  => 'PTR',
    record_class => $record_class,
    export_tag   => $export_tag,
    absent       => $absent,
    template     => $template,
    ttl          => $ttl,
    order        => $order,
  }
}
