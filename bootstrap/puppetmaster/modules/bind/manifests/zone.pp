# = Define: bind::zone
#
# This class adds a DNS zone.
# This class also subscribes to @concat::fragment with tag specified by
# tag option. So, if you want to add a specific record configuration into this
# zone just add the same tag as this zone into bind::record directive.
#
# If [*export_tag*] is not specify we will used the zone name.
#
# == Parameters:
#
# [*zone_name*]
#   zone name. Don't forget final point.
#   (Default: $name)
#
# [*zone_type*]
#   The zone type. Like master, slave, forward, etc ...
#   (Default: 'master')
#
# [*zone_class*]
#   Zone class
#   (Default: 'IN')
#
# [*zone_ttl*]
#   Zone TTL. empty mean no configuration
#   (Default: '')
#
# [*zone_contact*]
#   Zone email administrator
#   (Default: root.$zone_name)
#
# [*zone_refresh*]
#   Zone refresh time period.
#   (Default: '604800')
#
# [*zone_serial*]
#   Zone serial.
#   Actually this parameter is mandatory for master zone.
#   I'm not able to find how to dynamically process this one.
#
# [*zone_retry*]
#   Zone retry time period.
#   (Default: '86400')
#
# [*zone_expire*]
#   Zone expire time period.
#   (Default: '2419200')
#
# [*zone_neg_cache*]
#   Zone negative cache TTL.
#   (Default: '604800')
#
# [*zone_ns*]
#   Main nameserver for this zone. You have to add this one as A record.
#   (Default: 'ns.$zone_name')
#
# [*zone_master*]
#   Zone master server IP address. Use by slave zone.
#   (Default: '')
#
# [*zone_forward*]
#   Set of forwarders for the zone. Can be an array.
#   (Default: '')
#
# [*absent*]
#   Set to 'true' to remove zone.
#   (Default: 'false')
#
# [*template*]
#   Header template used for zone.
#   It contains SOA record.
#   (Default: 'bind/zone-header.erb')
#
# [*export_tag*]
#   Used tag for exported ressource
#   (Default: $zone_name)
#
# == Example:
#
# * Create a zone as master.
#
#   class { "bind": }
#   bind::zone { 'example.com':
#     zone_serial => 1,
#   }
#
# * Create a zone as slave.
#
#   class { "bind": }
#   bind::zone { 'example.com':
#     zone_type => 'slave',
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
define bind::zone(
  $zone_serial    = '',
  $zone_name      = $name,
  $zone_type      = 'master',
  $zone_class     = 'IN',
  $zone_ttl       = '',
  $zone_contact   = '',
  $zone_refresh   = '604800',
  $zone_retry     = '86400',
  $zone_expire    = '2419200',
  $zone_neg_cache = '604800',
  $zone_ns        = '',
  $zone_master    = '',
  $zone_forward   = '',
  $absent         = false,
  $template       = 'bind/zone-header.erb',
  $export_tag     = ''
  ) {

  $bool_absent = any2bool($absent)

  if $export_tag == '' {
    $real_export_tag = $zone_name
  } else {
    $real_export_tag = $export_tag
  }

  if $zone_ns == '' {
    $real_zone_ns = "ns.${zone_name}"
  } else {
    $real_zone_ns = $zone_ns
  }

  if $zone_contact == '' {
    $real_zone_contact = "root.${zone_name}"
  } else {
    $real_zone_contact = $zone_contact
  }

  include bind
  include concat::setup

  $zone_config_file = "db.${zone_name}.conf"

  if $bool_absent == false {

    # We have to create a zone config file only for master and hint
    # zone.
    #
    if $zone_type == 'master'
    or $zone_type == 'hint' {
      concat { "$bind::config_dir/$zone_config_file":
        mode   => $bind::config_file_mode,
        owner  => $bind::config_file_owner,
        group  => $bind::config_file_group,
        notify => $bind::manage_service_autorestart,
      }
      Concat::Fragment <| tag == "bind-zone-$real_export_tag" |> {
        target => "$bind::config_dir/$zone_config_file",
        order  => 50,
      }
    }

    # Register this subnet file into main configuration
    concat::fragment {"bind-include-zone-${zone_name}":
      target  => $bind::config_file,
      content => template( 'bind/named.conf-zone.erb' ),
      order   => 50,
    }

    if $zone_type== 'master' {
      concat::fragment{"bind-zone-${zone_name}-header":
        target  => "$bind::config_dir/$zone_config_file",
        content => template($template),
        order   => 01,
      }
    }
  } else {
    file{"zone-$zone_name":
      ensure => absent,
      path   => "$bind::config_dir/$zone_config_file",
    }
  }
}
