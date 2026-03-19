# frozen_string_literal: true

require 'spec_helper'

describe 'stunnel_install' do
  step_into :stunnel_install
  platform 'ubuntu', '22.04'

  context 'package install (default)' do
    recipe do
      stunnel_install 'default'
    end

    it { is_expected.to install_package('stunnel4') }
    it { is_expected.to create_directory('/etc/stunnel') }
  end

  context 'package install on RHEL' do
    platform 'almalinux', '9'

    recipe do
      stunnel_install 'default'
    end

    it { is_expected.to install_package('stunnel') }
    it { is_expected.to create_user('stunnel4') }
  end
end
