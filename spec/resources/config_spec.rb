# frozen_string_literal: true

require 'spec_helper'

describe 'stunnel_config' do
  step_into :stunnel_config
  platform 'ubuntu', '22.04'

  context 'create action with defaults' do
    recipe do
      stunnel_config 'default'
    end

    it { is_expected.to create_directory('/etc/stunnel') }
    it { is_expected.to create_directory('/etc/stunnel/conf.d') }
    it { is_expected.to create_template('/etc/stunnel/stunnel.conf') }
    it { is_expected.to render_file('/etc/stunnel/stunnel.conf').with_content(/client = yes/) }
    it { is_expected.to render_file('/etc/stunnel/stunnel.conf').with_content(/sslVersion = all/) }
    it { is_expected.to render_file('/etc/stunnel/stunnel.conf').with_content(%r{include = /etc/stunnel/conf.d}) }
  end

  context 'create with custom properties' do
    recipe do
      stunnel_config 'custom' do
        config_file '/etc/stunnel/custom.conf'
        client_mode false
        ssl_version 'TLSv1.2'
        use_chroot true
        chroot_path '/var/lib/stunnel'
      end
    end

    it { is_expected.to create_template('/etc/stunnel/custom.conf') }
    it { is_expected.to create_directory('/var/lib/stunnel') }
    it { is_expected.to render_file('/etc/stunnel/custom.conf').with_content(/sslVersion = TLSv1.2/) }
    it { is_expected.to render_file('/etc/stunnel/custom.conf').with_content(%r{chroot = /var/lib/stunnel}) }
  end

  context 'delete action' do
    recipe do
      stunnel_config 'default' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/stunnel/stunnel.conf') }
  end
end
