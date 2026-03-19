# frozen_string_literal: true

require 'spec_helper'

describe 'stunnel_service' do
  step_into :stunnel_service
  platform 'ubuntu', '22.04'

  context 'create action' do
    recipe do
      stunnel_service 'stunnel'
    end

    it { is_expected.to create_systemd_unit('stunnel.service') }
    it { is_expected.to enable_systemd_unit('stunnel.service') }
    it { is_expected.to start_systemd_unit('stunnel.service') }
  end

  context 'create with custom name' do
    recipe do
      stunnel_service 'my-tunnel' do
        config_file '/etc/stunnel/custom.conf'
      end
    end

    it { is_expected.to create_systemd_unit('my-tunnel.service') }
    it { is_expected.to enable_systemd_unit('my-tunnel.service') }
    it { is_expected.to start_systemd_unit('my-tunnel.service') }
  end

  context 'delete action' do
    recipe do
      stunnel_service 'stunnel' do
        action :delete
      end
    end

    it { is_expected.to stop_systemd_unit('stunnel.service') }
    it { is_expected.to disable_systemd_unit('stunnel.service') }
    it { is_expected.to delete_systemd_unit('stunnel.service') }
  end
end
