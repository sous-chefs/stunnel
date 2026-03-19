# frozen_string_literal: true

title 'Default Tests'

control 'stunnel-install-01' do
  impact 1.0
  title 'stunnel package is installed'
  desc 'The stunnel package should be installed'

  if os.debian?
    describe package('stunnel4') do
      it { should be_installed }
    end
  else
    describe package('stunnel') do
      it { should be_installed }
    end
  end
end

control 'stunnel-config-01' do
  impact 1.0
  title 'stunnel configuration directory exists'

  describe directory('/etc/stunnel') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
end

control 'stunnel-config-02' do
  impact 1.0
  title 'stunnel main configuration file exists'

  describe file('/etc/stunnel/stunnel.conf') do
    it { should exist }
    its('mode') { should cmp '0644' }
    its('content') { should match(/client = yes/) }
  end
end

control 'stunnel-connection-01' do
  impact 1.0
  title 'stunnel connection config files exist'

  describe file('/etc/stunnel/conf.d/server.conf') do
    it { should exist }
    its('content') { should match(/accept = 8080/) }
    its('content') { should match(/connect = 80/) }
  end

  describe file('/etc/stunnel/conf.d/client.conf') do
    it { should exist }
    its('content') { should match(/accept = 9090/) }
    its('content') { should match(/connect = localhost:8080/) }
    its('content') { should match(/client = yes/) }
  end
end

control 'stunnel-service-01' do
  impact 1.0
  title 'stunnel service is running'

  describe systemd_service('stunnel') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
