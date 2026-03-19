# frozen_string_literal: true

title 'Certificate Tests'

control 'stunnel-cert-01' do
  impact 1.0
  title 'stunnel certificate directory exists'

  describe directory('/etc/stunnel/certificates') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
end

control 'stunnel-cert-02' do
  impact 1.0
  title 'CA certificate is deployed'

  describe file('/etc/stunnel/certificates/ca.pem') do
    it { should exist }
    its('mode') { should cmp '0700' }
    its('content') { should match(/BEGIN CERTIFICATE/) }
  end
end

control 'stunnel-cert-03' do
  impact 1.0
  title 'Server certificate is deployed'

  describe file('/etc/stunnel/certificates/cert.pem') do
    it { should exist }
    its('mode') { should cmp '0700' }
    its('content') { should match(/BEGIN CERTIFICATE/) }
  end
end

control 'stunnel-cert-04' do
  impact 1.0
  title 'Client certificate is deployed'

  describe file('/etc/stunnel/certificates/cert-client.pem') do
    it { should exist }
    its('mode') { should cmp '0700' }
    its('content') { should match(/BEGIN CERTIFICATE/) }
  end
end

control 'stunnel-cert-05' do
  impact 1.0
  title 'stunnel connection configs reference certificates'

  describe file('/etc/stunnel/conf.d/server.conf') do
    it { should exist }
    its('content') { should match(%r{CAfile = /etc/stunnel/certificates/ca.pem}) }
    its('content') { should match(%r{cert = /etc/stunnel/certificates/cert.pem}) }
    its('content') { should match(/verify = 2/) }
  end

  describe file('/etc/stunnel/conf.d/client.conf') do
    it { should exist }
    its('content') { should match(%r{CAfile = /etc/stunnel/certificates/ca.pem}) }
    its('content') { should match(%r{cert = /etc/stunnel/certificates/cert-client.pem}) }
    its('content') { should match(/verify = 2/) }
    its('content') { should match(/client = yes/) }
  end
end

control 'stunnel-cert-06' do
  impact 1.0
  title 'stunnel service is running'

  describe systemd_service('stunnel') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
