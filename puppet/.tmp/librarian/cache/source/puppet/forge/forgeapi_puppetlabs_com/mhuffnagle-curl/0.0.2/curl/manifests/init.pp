# == Class: curl
#
# Installs curl.  Nothing exciting, but makes it easier for other modules to
# require curl.
#
# === Parameters
#
# There are no parameters at this time.
#
class curl (
) inherits curl::params {

  # validate parameters here

  class { 'curl::install': } -> Class['curl']
}
