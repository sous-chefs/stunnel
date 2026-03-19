# frozen_string_literal: true

require 'spec_helper'

describe 'stunnel_connection' do
  step_into :stunnel_connection
  platform 'ubuntu', '22.04'

  context 'create action' do
    recipe do
      stunnel_connection 'redis' do
        connect '10.0.0.1:6379'
        accept '127.0.0.1:6380'
        cafile '/etc/ssl/certs/ca-certificates.crt'
      end
    end

    it { is_expected.to create_directory('/etc/stunnel/conf.d') }
    it { is_expected.to create_file('/etc/stunnel/conf.d/redis.conf').with_content(/connect = 10.0.0.1:6379/) }
    it { is_expected.to create_file('/etc/stunnel/conf.d/redis.conf').with_content(/accept = 127.0.0.1:6380/) }
    it { is_expected.to create_file('/etc/stunnel/conf.d/redis.conf').with_content(%r{CAfile = /etc/ssl/certs/ca-certificates.crt}) }
  end

  context 'create with client mode' do
    recipe do
      stunnel_connection 'client-tunnel' do
        connect 'remote:6379'
        accept '127.0.0.1:6380'
        client true
      end
    end

    it { is_expected.to create_file('/etc/stunnel/conf.d/client-tunnel.conf').with_content(/client = yes/) }
  end

  context 'delete action' do
    recipe do
      stunnel_connection 'redis' do
        connect '10.0.0.1:6379'
        accept '127.0.0.1:6380'
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/stunnel/conf.d/redis.conf') }
  end
end
