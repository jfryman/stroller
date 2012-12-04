# = Define: bind::txt
#
# Create a A TXT record.
# See bind::record for more informations
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
define bind::txt (
  $zone,
  $target,
  $host         = $name,
  $record_class = 'IN',
  $export_tag   = $zone,
  $absent       = false,
  $template     = 'bind/record.erb',
  $ttl          = '',
  $order        = '30'
  ) {

  bind::record { "TXT-$name":
    zone         => $zone,
    target       => $target,
    host         => $host,
    record_type  => 'TXT',
    record_class => $record_class,
    export_tag   => $export_tag,
    absent       => $absent,
    template     => $template,
    ttl          => $ttl,
    order        => $order,
  }
}
