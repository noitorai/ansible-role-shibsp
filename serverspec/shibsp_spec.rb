require 'serverspec'
require 'spec_helper'

describe 'httpd packages' do
  describe package('httpd') do
    it { should be_installed }
  end
  describe service('httpd') do
    it { should be_enabled }
    it { should be_running }
  end
end

describe 'shibboleth packages'  do
  describe package('shibboleth') do
    it { should be_installed }
  end
  describe service('shibd') do
    it { should be_enabled }
    it { should be_running }
  end
end
