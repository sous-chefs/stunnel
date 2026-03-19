# frozen_string_literal: true

title 'Source Install Tests'

control 'stunnel-source-01' do
  impact 1.0
  title 'stunnel binary is installed from source'

  describe file('/usr/local/bin/stunnel') do
    it { should exist }
    it { should be_executable }
  end
end

control 'stunnel-source-02' do
  impact 1.0
  title 'stunnel symlink exists'

  describe file('/usr/bin/stunnel') do
    it { should exist }
    it { should be_symlink }
    its('link_path') { should eq '/usr/local/bin/stunnel' }
  end
end

control 'stunnel-source-03' do
  impact 1.0
  title 'stunnel configuration exists'

  describe file('/etc/stunnel/stunnel.conf') do
    it { should exist }
    its('mode') { should cmp '0644' }
  end
end

control 'stunnel-source-04' do
  impact 1.0
  title 'stunnel service is running'

  describe systemd_service('stunnel') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
