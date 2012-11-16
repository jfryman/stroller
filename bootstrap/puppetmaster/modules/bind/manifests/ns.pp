# = Define: bind::ns
#
# Create a NS DNS record.
# See bind::record for more informations
#
# There is no need of host parameters for NS entry.
# Target default value is $name.
#
# == Examples:
#
# bind::ns { 'ns.example42.com':
#   zone   => 'example42.com',
# }
#
# bind::ns { 'ns.example42.com':
#   zone   => 'example42.com',
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
define bind::ns (
  $zone,
  $target       = $name,
  $record_class = 'IN',
  $export_tag   = $zone,
  $absent       = false,
  $template     = 'bind/record.erb',
  $ttl          = '',
  $order        = '0'
  ) {

  bind::record { "NS-$name":
    zone         => $zone,
    target       => $target,
    host         => '',
    record_type  => 'NS',
    record_class => $record_class,
    export_tag   => $export_tag,
    absent       => $absent,
    template     => $template,
    ttl          => $ttl,
    order        => $order
  }
}
