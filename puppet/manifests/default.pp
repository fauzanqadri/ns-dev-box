$as_vagrant = "sudo -u vagrant -H bash -l -c"
$home = "/home/vagrant"

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# ------------------------ Pre Install Stage --------------------------

stage { 'preinstall':
  before => Stage['main']
}

stage { 'post_main': }
Stage['main']->Stage['post_main']

include apt

apt::source { 'kambing_ui':
  location => 'http://kambing.ui.ac.id/ubuntu/',
  repos    => 'main'
}
class apt_get_update {
  exec { 'apt-get update -y':}
}

class { 'apt_get_update':
  stage => preinstall
}


# ------------------------ Main Stage --------------------------

include curl

package { 'git-core': ensure         => "installed" }
package { 'build-essential': ensure  => "installed" }
package { 'bison': ensure            => "installed" }
package { 'zlib1g-dev': ensure       => "installed" }
package { 'libssl-dev': ensure       => "installed" }
package { 'libxml2-dev': ensure      => "installed" }
package { 'autotools-dev': ensure    => "installed" }
package { 'libxslt1-dev': ensure     => "installed" }
package { 'libyaml-0-2': ensure      => "installed" }
package { 'autoconf': ensure         => "installed" }
package { 'automake': ensure         => "installed" }
package { 'libxmu-dev': ensure       => "installed" }
package { 'libreadline6-dev': ensure => "installed" }
package { 'libyaml-dev': ensure      => "installed" }
package { 'libtool': ensure          => "installed" }
package { 'xauth': ensure            => "installed" }
package { 'x11-apps': ensure         => "installed" }
package { 'openjdk-7-jre': ensure    => "installed" }


# ------------------------ Post Main Stage --------------------------

class download_ns2_source {
  curl::fetch { 'ns-allinone-2.35':
    source      => 'https://codeload.github.com/paultsr/ns-allinone-2.35/legacy.tar.gz/master',
    destination   => '/usr/src/ns-allinone-2.35.tar.gz'
  }
}
class create_ns2_directory {
  file { "/usr/local/ns-allinone-2.35":
    ensure => "directory"
  }
}
class extract_ns2_source {
  exec { "extract_ns2_source":
    command => "tar zxvf /usr/src/ns-allinone-2.35.tar.gz -C /usr/local/ns-allinone-2.35 --strip-components=1"
  }
}
class build_ns2_source {
  exec { "build_ns2_source":
    command => "./install",
    cwd     => "/usr/local/ns-allinone-2.35"
  }
}
class { 'download_ns2_source':
  stage => post_main
}->
class { 'create_ns2_directory':
  stage => post_main
}->
class{ 'extract_ns2_source':
  stage => post_main
}->
class{ 'build_ns2_source':
  stage=> post_main
}
