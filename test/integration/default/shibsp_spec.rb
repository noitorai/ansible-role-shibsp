# encoding: utf-8
# author: ISHII Masaru

title 'test of Shibboleth SP'

hostname = attribute('hostname', default: "sp.example.ac.jp")
servername = attribute('servername', default: hostname)
entity_id = attribute('entity_id', default: "https://#{servername}/shibboleth-sp")
idp_entity_id = attribute('idp_entity_id', default: "https://idp.example.org/idp/shibboleth")
idp_metadata_path= attribute('idp_metadata_path', default: "idp-metadata.xml")
certificate_path = attribute('certificate_path', default: "cert/server.crt")
secret_path = attribute('secret_path', default: "cert/server.key")

control 'shibsp-1.0' do
  impact 1.0
  title 'Verify Shibboleth SP service'
  desc '' 
  tag ''

  describe package('httpd') do
    it { should be_installed }
  end
  describe service('httpd') do
    it { should be_enabled }
    it { should be_running }
  end
#  describe file('/etc/httpd/conf.d/ssl.conf') do
#    it { should be_file }
#    it { should contain('ServerName sp.example.ac.jp') }
#    its(:content) { is_expected.to match(/^ServerName\ssp.example.ac.jp/) }
#    it { should contain('ServerName sp.example.ac.jp').from(/^<VirtualHost _default_:443>/).to(/^<\/VirtualHost>/) }
#  end
#end

  describe package('shibboleth') do
    it { should be_installed }
  end
  describe service('shibd') do
    it { should be_enabled }
    it { should be_running }
  end
  describe file('/etc/shibboleth/shibboleth2.xml') do
    it { should be_file }
  end
  describe xml('/etc/shibboleth/shibboleth2.xml') do
      its('/SPConfig/ApplicationDefaults/@entityID') { should eq [entity_id] }
#      its(doc.xpath('//xmlns:ApplicationDefaults/@entityID').to_s) { 
#        is_expected.to eq(entity_id)
#      }
      its('/SPConfig/ApplicationDefaults/Sessions/SSO/@entityID') { should eq [idp_entity_id] }
      its('/SPConfig/ApplicationDefaults/MetadataProvider/@file') { should eq [idp_metadata_path] }
      its('/SPConfig/ApplicationDefaults/CredentialResolver[@use="signing"]/@key') { should eq [secret_path] }
      its('/SPConfig/ApplicationDefaults/CredentialResolver[@use="signing"]/@certificate') { should eq [certificate_path] }
      its('/SPConfig/ApplicationDefaults/CredentialResolver[@use="encryption"]/@key') { should eq [secret_path] }
      its('/SPConfig/ApplicationDefaults/CredentialResolver[@use="encryption"]/@certificate') { should eq [certificate_path] }
  end
end
