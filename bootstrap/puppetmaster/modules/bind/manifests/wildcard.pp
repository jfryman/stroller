# = Define: bind::wildcard
#
# Create a A DNS record with a preset weight for a wildcard record.
# See bind::record for more informations
#
# == Parameters
#
# [*order*]
#   Override's the default order from bind::record to be a high value. If you
#   for some reason have more than 999999 records you will need to increase
#   the order value.
#   (Default: '999999')
#
# == Examples
#
# * Create a wildcard record for example42.com zone
#
# bind::wildcard{ 'example42.com':
#   target => '42.42.42.42',
#   zone   => 'example42.com',
# }
#
# == Authors
#
# * dvestal
# * Romain THERRAT <romain42@gmail.com>
#
# Based on Example42 rules
# Alessandro Franceschi <al@lab42.it/>
#
# == Copyright
#
# Released under the terms of Apache2 licence.
#
define bind::wildcard (
  $target,
  $zone         = $name,
  $host         = '*',
  $record_class = 'IN',
  $export_tag   = $zone,
  $absent       = false,
  $template     = 'bind/record.erb',
  $ttl          = '',
  $order        = '999999'
  ) {

  bind::record { "wildcard-$name":
    zone         => $zone,
    target       => $target,
    host         => $host,
    record_type  => 'A',
    record_class => $record_class,
    export_tag   => $export_tag,
    absent       => $absent,
    template     => $template,
    ttl          => $ttl,
    order        => $order
  }
}
