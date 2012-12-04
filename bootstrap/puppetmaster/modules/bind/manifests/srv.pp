# = Define: bind::srv
#
# Create a SRV DNS record.
# See bind::record for more informations
#
# == Parameters:
#
# [*record_port*]
# Port number assign to this symbolic entry.
#
# [*record_weight*]
# Used when more than one service has the same priority.
# (Default: 0)
#
# [*record_priority*]
# Priority of the entry. Low value are more preferred.
# (Default: 0)
#
# == Examples:
#
# bind::srv { '_http._tcp.example42.com':
#   zone        => 'example42.com',
#   target      => 'www.example42.com.',
#   record_port => 80,
# }
#
# If you have many server for one service you can use priority and weight.
#
# bind::srv { '_http._tcp.example42.com-1':
#   host            => '_http._tcp.example42.com',
#   zone            => 'example42.com',
#   target          => 'www1.example42.com.',
#   record_port     => 80,
#   record_priority => 10,
#   record_weight   => 10,
# }
#
# bind::srv { '_http._tcp.example42.com-2':
#   host            => '_http._tcp.example42.com',
#   zone            => 'example42.com',
#   target          => 'www2.example42.com.',
#   record_port     => 80,
#   record_priority => 20,
#   record_weight   => 10,
# }
#
# bind::srv { '_http._tcp.example42.com-3':
#   host            => '_http._tcp.example42.com',
#   zone            => 'example42.com',
#   target          => 'www3.example42.com.',
#   record_port     => 80,
#   record_priority => 10,
#   record_weight   => 20,
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
define bind::srv (
  $zone,
  $target,
  $record_port,
  $host            = $name,
  $record_class    = 'IN',
  $record_priority = '0',
  $record_weight   = '0',
  $export_tag      = $zone,
  $absent          = false,
  $template        = 'bind/record.erb',
  $ttl             = '',
  $order           = '20'
  ) {

  $real_priority = "$record_priority $record_weight $record_port"

  bind::record { "SRV-$name":
    zone            => $zone,
    target          => $target,
    host            => $host,
    record_type     => 'SRV',
    record_priority => $real_priority,
    record_class    => $record_class,
    export_tag      => $export_tag,
    absent          => $absent,
    template        => $template,
    ttl             => $ttl,
    order           => $order,
  }
}
