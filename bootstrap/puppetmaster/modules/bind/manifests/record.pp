# = Define: bind::record
#
# If no [*tag_export*] is specify we will used the zone name.
#
# == Parameters:
#
# [*zone*]
#   Name of the zone. (Like google.com)
#
# [*target*]
#   Record target.
#
# [*host*]
#   Name of the host to add. (Like www, www.example.com, ...)
#   (Default: $name)
#
# [*record_type*]
#   Record record_type.
#   (Default: 'A')
#
# [*record_class*]
#   Record class
#   (Default: 'IN')
#
# [*record_priority*]
#   The record priority for MX or SRV entry.
#
# [*export_tag*]
#   Used tag for exported ressource
#   (Default: $zone_name)
#
# [*absent*]
#   Set to 'true' to remove zone.
#   (Default: 'false')
#
# [*template*]
#   Used template file.
#   (Default: 'bind/record.erb')
#
# [*order*]
#   Allow an order to be set so that wildcard entries can be set at the end
#   of the zone file. The default value is taken from the upstream
#   @concat::fragment definition.
#   (Default: '10')
#
# == Example:
#
# * Create A record. www -> 192.168.0.10
#
#   bind::record { 'www.example.com.':
#     zone   => 'example.com.',
#     target => '192.168.0.10',
#   }
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
define bind::record (
  $zone,
  $target,
  $host            = $name,
  $record_type     = 'A',
  $record_class    = 'IN',
  $record_priority = '',
  $export_tag      = $zone,
  $absent          = false,
  $template        = 'bind/record.erb',
  $ttl             = '',
  $order           = '10'
  ) {

  if $absent == false {
    @concat::fragment { "bind-zone-${zone}-${order}-${host}-${target}":
      tag     => "bind-zone-$export_tag",
      content => template($template),
      order   => $order
    }
  }

}
