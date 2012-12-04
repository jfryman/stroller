# = Class: bind::default_zone
#
# This class provide some pre-configured default zone.
# For the instance this class add the '.' zone with some record.
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
class bind::default_zone{

  # Root zone
  bind::zone{ '.':
    zone_type => 'hint',
    template  => 'bind/empty.erb',
  }
  # Root A
  bind::record{ 'root-A-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'A.ROOT-SERVERS.NET.',
  }
  bind::record { 'A.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '198.41.0.4',
  }
  bind::record { 'A.ROOT-SERVERS.NET.IPv6':
    zone        => '.',
    host        => 'A.ROOT-SERVERS.NET.',
    ttl         => '3600000',
    target      => '2001:503:BA3E::2:30',
    record_type => 'AAAA',
  }
  # Root B
  bind::record{ 'root-B-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'B.ROOT-SERVERS.NET.',
  }
  bind::record { 'B.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '192.228.79.201',
  }
  # Root C
  bind::record{ 'root-C-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'C.ROOT-SERVERS.NET.',
  }
  bind::record { 'C.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '192.33.4.12',
  }
  # Root D
  bind::record{ 'root-D-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'D.ROOT-SERVERS.NET.',
  }
  bind::record { 'D.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '128.8.10.90',
  }
  # Root E
  bind::record{ 'root-E-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'E.ROOT-SERVERS.NET.',
  }
  bind::record { 'E.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '192.203.230.10',
  }
  # Root F
  bind::record{ 'root-F-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'F.ROOT-SERVERS.NET.',
  }
  bind::record { 'F.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '192.5.5.241',
  }
  bind::record { 'F.ROOT-SERVERS.NET.IPv6':
    zone        => '.',
    host        => 'F.ROOT-SERVERS.NET.',
    ttl         => '3600000',
    target      => '2001:500:2F::F',
    record_type => 'AAAA',
  }
  # Root F
  bind::record{ 'root-G-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'G.ROOT-SERVERS.NET.',
  }
  bind::record { 'G.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '192.112.36.4',
  }
  # Root H
  bind::record{ 'root-H-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'H.ROOT-SERVERS.NET.',
  }
  bind::record { 'H.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '128.63.2.53',
  }
  bind::record { 'H.ROOT-SERVERS.NET.IPv6':
    zone        => '.',
    host        => 'H.ROOT-SERVERS.NET.',
    ttl         => '3600000',
    target      => '2001:500:1::803F:235',
    record_type => 'AAAA',
  }
  # Root I
  bind::record{ 'root-I-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'I.ROOT-SERVERS.NET.',
  }
  bind::record { 'I.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '192.36.148.17',
  }
  bind::record { 'I.ROOT-SERVERS.NET.IPv6':
    zone        => '.',
    host        => 'I.ROOT-SERVERS.NET.',
    ttl         => '3600000',
    target      => '2001:7FE::53',
    record_type => 'AAAA',
  }
  # Root J
  bind::record{ 'root-J-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'J.ROOT-SERVERS.NET.',
  }
  bind::record { 'J.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '192.58.128.30',
  }
  bind::record { 'J.ROOT-SERVERS.NET.IPv6':
    zone        => '.',
    host        => 'J.ROOT-SERVERS.NET.',
    ttl         => '3600000',
    target      => '2001:503:C27::2:30',
    record_type => 'AAAA',
  }
  # Root K
  bind::record{ 'root-K-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'K.ROOT-SERVERS.NET.',
  }
  bind::record { 'K.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '193.0.14.129',
  }
  bind::record { 'K.ROOT-SERVERS.NET.IPv6':
    zone        => '.',
    host        => 'K.ROOT-SERVERS.NET.',
    ttl         => '3600000',
    target      => '2001:7FD::1',
    record_type => 'AAAA',
  }
  # Root L
  bind::record{ 'root-L-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'L.ROOT-SERVERS.NET.',
  }
  bind::record { 'L.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '199.7.83.42',
  }
  bind::record { 'L.ROOT-SERVERS.NET.IPv6':
    zone        => '.',
    host        => 'L.ROOT-SERVERS.NET.',
    ttl         => '3600000',
    target      => '2001:500:3::42',
    record_type => 'AAAA',
  }
  # Root M
  bind::record{ 'root-M-NS':
    zone        => '.',
    host        => '.',
    ttl         => '3600000',
    record_type => 'NS',
    target      => 'M.ROOT-SERVERS.NET.',
  }
  bind::record { 'M.ROOT-SERVERS.NET.':
    zone   => '.',
    ttl    => '3600000',
    target => '202.12.27.33',
  }
  bind::record { 'M.ROOT-SERVERS.NET.IPv6':
    zone        => '.',
    host        => 'M.ROOT-SERVERS.NET.',
    ttl         => '3600000',
    target      => '2001:DC3::35',
    record_type => 'AAAA',
  }

  # localhost
  bind::zone{ 'localhost':
    zone_type      => 'master',
    zone_ttl       => '604800',
    zone_serial    => 2,
    zone_neg_cache => '604800',
    zone_ns        => 'localhost.',
  }
  bind::record { 'localhost-A':
    zone   => 'localhost',
    host   => '@',
    target => '127.0.0.1',
  }
  bind::record { 'localhost-AAAA':
    zone        => 'localhost',
    host        => '@',
    record_type => 'AAAA',
    target      => '::1',
  }

  # localhost reverse
  bind::zone{ '127.in-addr.arpa':
    zone_type      => 'master',
    zone_ttl       => '604800',
    zone_serial    => 1,
    zone_neg_cache => '604800',
    zone_ns        => 'localhost.',
    zone_contact   => 'root.localhost.',
  }
  bind::record { '1.0.0':
    zone        => '127.in-addr-arpa',
    record_type => 'PTR',
    target      => 'localhost.',
  }

  # reverse 0
  bind::zone{ '0.in-addr.arpa':
    zone_type      => 'master',
    zone_ttl       => '604800',
    zone_serial    => 1,
    zone_neg_cache => '604800',
    zone_ns        => 'localhost.',
    zone_contact   => 'root.localhost.',
  }

  # reverse 255
  bind::zone{ '255.in-addr.arpa':
    zone_type      => 'master',
    zone_ttl       => '604800',
    zone_serial    => 1,
    zone_neg_cache => '604800',
    zone_ns        => 'localhost.',
    zone_contact   => 'root.localhost.',
  }
}
