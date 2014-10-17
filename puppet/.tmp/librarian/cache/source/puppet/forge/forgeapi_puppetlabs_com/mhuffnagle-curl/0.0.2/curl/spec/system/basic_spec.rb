require 'spec_helper_system'

describe 'basic tests' do
  before(:all) do
    puppet_apply 'include curl'
  end

  describe package('curl') do
    it { should be_installed }
  end

end
