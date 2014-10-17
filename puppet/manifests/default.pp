$as_vagrant = "sudo -u vagrant -H bash -l -c"
$home = "/home/vagrant"

include apt

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# ------------------------ Pre Install Stage --------------------------

apt::source { 'kambing_ui':
  location => 'http://kambing.ui.ac.id/ubuntu/',
  repos    => 'main'
}

stage { 'preinstall':
  before => Stage['main']
}
stage { 'post_main': }
Stage['main']->Stage['post_main']

class apt_get_update {
  exec { 'apt-get update -y':}
}

class { 'apt_get_update':
  stage => preinstall
}


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

class download_ns2_source {
  curl::fetch { 'ns-allinone-2.35':
    source      => 'https://dl.dropboxusercontent.com/u/24623828/ns-allinone-2.35.tar.gz',
    destination   => '/usr/src/ns-allinone-2.35.tar.gz'
  }
}
class download_ns2_patch {
  curl::fetch { "download":
    source      => "https://dl.dropboxusercontent.com/u/55796430/ns_patchfile",
    destination => "/home/vagrant/ns_patch.diff"
  }
}
class patch_ns2_source {
  patch::file {"/opt/ns-allinone-2.35/ns-2.35/linkstate/ls.h":
    target      => "/opt/ns-allinone-2.35/ns-2.35/linkstate/ls.h",
    diff_source => "/home/vagrant/ns_patch.diff"
  }
}
class extract_ns2_source {
  exec { "extract_ns2_source":
    command => "tar zxvf /usr/src/ns-allinone-2.35.tar.gz -C /opt"
  }
}
class build_ns2_source {
  exec { "build_ns2_source":
    command => "./install",
    cwd     => "/opt/ns-allinone-2.35"
  }
}
class { 'download_ns2_source':
  stage => post_main
}->
class { 'download_ns2_patch':
  stage => post_main
}->
class{ 'extract_ns2_source':
  stage => post_main
}->
class{ 'patch_ns2_source':
  stage=> post_main
}->
class{ 'build_ns2_source':
  stage=> post_main
}
