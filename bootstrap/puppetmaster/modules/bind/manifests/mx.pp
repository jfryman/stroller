# = Define: bind::mx
#
# Create a MX DNS record.
# See bind::record for more informations
#
# There is no need of host parameters for MX entry.
# Target default value is $name.
#
# == Examples:
#
# bind::mx { 'mail.example42.com':
#   zone   => 'example42.com',
# }
#
# In order to manage many MX server with priority order you can use the
# record_priority parameters
#
# bind::mx { 'mail1.example42.com':
#   zone            => 'example42.com',
#   record_priority => 10,
# }
#
# bind::mx { 'mail2.example42.com':
#   zone            => 'example42.com',
#   record_priority => 20,
# }
#
# Remove a MX record
#
# bind::mx { 'mail.example42.com':
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
define bind::mx (
  $zone,
  $target          = $name,
  $record_class    = 'IN',
  $record_priority = '0',
  $export_tag      = $zone,
  $absent          = false,
  $template        = 'bind/record.erb',
  $ttl             = '',
  $order           = '10'
  ) {

  bind::record { "MX-$name":
    zone            => $zone,
    target          => $target,
    host            => '',
    record_type     => 'MX',
    record_class    => $record_class,
    record_priority => $record_priority,
    export_tag      => $export_tag,
    absent          => $absent,
    template        => $template,
    ttl             => $ttl,
    order           => $order,
  }
}
