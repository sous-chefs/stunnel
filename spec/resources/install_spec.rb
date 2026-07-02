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

  context 'source install' do
    recipe do
      stunnel_install 'default' do
        install_method 'source'
      end
    end

    it { is_expected.to install_package('ca-certificates') }
    it { is_expected.to install_package('tar') }
    it { is_expected.to install_package('libssl-dev') }
    it { is_expected.to create_remote_file("#{Chef::Config[:file_cache_path]}/stunnel.tar.gz") }
    it { is_expected.to run_bash('compile_stunnel') }
  end

  context 'source install on Fedora' do
    platform 'fedora', '44'

    recipe do
      stunnel_install 'default' do
        install_method 'source'
      end
    end

    it { is_expected.to install_package('openssl-devel') }
    it { is_expected.to create_remote_file("#{Chef::Config[:file_cache_path]}/stunnel.tar.gz") }
  end
end
