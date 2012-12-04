# = Define: bind::aaaa
#
# Create a AAAA DNS record.
# See record or a defined ressource for more informations
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
define bind::aaaa (
  $zone,
  $target,
  $host         = $name,
  $record_class = 'IN',
  $export_tag   = $zone,
  $absent       = false,
  $template     = 'bind/record.erb',
  $ttl          = '',
  $order        = '50'
  ) {

  bind::record { "AAAA-$name":
    zone         => $zone,
    target       => $target,
    host         => $host,
    record_type  => 'AAAA',
    record_class => $record_class,
    export_tag   => $export_tag,
    absent       => $absent,
    template     => $template,
    ttl          => $ttl,
    order        => $order,
  }
}
