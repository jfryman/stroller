class ruby {

  $ruby_packages = [
    'rake',
    'ruby1.8'
  ]

  package { $ruby_packages:
    ensure => 'present'
  }
}
