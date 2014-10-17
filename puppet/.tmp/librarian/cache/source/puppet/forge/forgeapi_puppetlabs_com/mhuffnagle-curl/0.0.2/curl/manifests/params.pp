# == Class curl::params
#
# This class is meant to be called from curl
# It sets variables according to platform
#
class curl::params {
  case $::osfamily {
    'Amazon', 'Debian', 'RedHat', 'Solaris': {
      $package_name = 'curl'
      $service_name = 'curl'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
