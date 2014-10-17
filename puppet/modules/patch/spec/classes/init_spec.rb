require 'spec_helper'

describe 'patch' do
  let(:title) { 'patch' }
  let(:facts) { {:puppet_vardir => '/var/lib/puppet'} }

  describe 'by default' do
    let(:params) { {} }

    it { should contain_package('patch').with_ensure('installed') }
    it { should contain_file('/var/lib/puppet/patch').with_ensure('directory') }
  end

  describe 'with version' do
    let(:params) { {:ensure => '1.0'} }

    it { should contain_package('patch').with_ensure('1.0') }
  end

  describe 'with ensure absent' do
    let(:params) { {:ensure => 'absent'} }

    it { should contain_package('patch').with_ensure('absent') }
    it { should contain_file('/var/lib/puppet/patch').with_ensure('absent') }
  end
end
