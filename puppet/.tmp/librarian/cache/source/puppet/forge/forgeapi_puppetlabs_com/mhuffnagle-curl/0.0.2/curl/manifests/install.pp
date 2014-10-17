# == Class curl::intall
#
class curl::install {
  include curl::params

  package { $curl::params::package_name:
    ensure => present,
  }
}
