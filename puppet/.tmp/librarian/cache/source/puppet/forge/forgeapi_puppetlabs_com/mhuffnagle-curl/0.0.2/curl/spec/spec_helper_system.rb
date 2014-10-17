require 'rspec-system/spec_helper'
require 'rspec-system-puppet/helpers'
require 'rspec-system-serverspec/helpers'

include Serverspec::Helper::RSpecSystem
include Serverspec::Helper::DetectOS

include RSpecSystemPuppet::Helpers

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  c.tty = true
  c.include RSpecSystemPuppet::Helpers

  c.before :suite do
    puppet_install
    puppet_module_install(:source => proj_root, :module_name => 'curl')
    shell('puppet module install puppetlabs-stdlib')
    case node.facts['osfamily'].downcase
    when 'debian'
      shell('apt-get -y remove curl')
    when 'redhat'
      shell('rpm -e curl')
    else
      raise "Don't know how to test against #{node.facts['os']}."
    end
  end
end
