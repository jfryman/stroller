class puppet(
  $master = false,
  $client = true
) {
  include stdlib

  class { 'puppet::repository': }
}
