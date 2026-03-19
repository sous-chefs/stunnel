# frozen_string_literal: true

require 'spec_helper'

describe 'stunnel_connection' do
  step_into :stunnel_connection
  platform 'ubuntu', '22.04'

  context 'create action' do
    recipe do
      node.default['stunnel']['services'] = {}
      stunnel_connection 'redis' do
        connect '10.0.0.1:6379'
        accept '127.0.0.1:6380'
        cafile '/etc/ssl/certs/ca-certificates.crt'
      end
    end

    it 'converges successfully' do
      expect { chef_run }.not_to raise_error
    end
  end

  context 'delete action' do
    recipe do
      node.default['stunnel']['services'] = {}
      stunnel_connection 'redis' do
        connect '10.0.0.1:6379'
        accept '127.0.0.1:6380'
        action :delete
      end
    end

    it 'converges successfully' do
      expect { chef_run }.not_to raise_error
    end
  end
end
