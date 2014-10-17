require 'spec_helper'

describe 'curl' do
  context 'supported operating systems' do
    ['Amazon', 'Debian', 'RedHat', 'Solaris'].each do |osfamily|
      describe "curl class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should include_class('curl::params') }
        it { should contain_class('curl::install') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'curl class without any parameters on Mandrake/Mandrake' do
      let(:facts) {{
        :osfamily        => 'Mandrake',
        :operatingsystem => 'MandrivaMandriva',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Mandriva not supported/) }
    end
  end
end
