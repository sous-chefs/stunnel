# frozen_string_literal: true

provides :stunnel_install
unified_mode true

default_action :create

property :install_method, String, default: 'package', equal_to: %w(package source)
property :packages, Array, default: lazy { platform_family?('debian') ? %w(stunnel4) : %w(stunnel) }
property :source_url, String, default: 'https://www.stunnel.org/archive/4.x/stunnel-4.56.tar.gz'
property :source_checksum, String, default: '9cae2cfbe26d87443398ce50d7d5db54e5ea363889d5d2ec8d2778a01c871293'
property :ssl_devel_package, String, default: lazy { platform_family?('debian') ? 'libssl-dev' : 'openssl-devel' }

action :create do
  if new_resource.install_method == 'source'
    build_essential 'stunnel'

    package new_resource.ssl_devel_package

    remote_file "#{Chef::Config[:file_cache_path]}/stunnel.tar.gz" do
      source new_resource.source_url
      checksum new_resource.source_checksum
    end

    bash 'compile_stunnel' do
      code <<-EOF
        tar xvzf stunnel.tar.gz
        cd stunnel-*
        ./configure
        make
        make install-exec
      EOF
      cwd Chef::Config[:file_cache_path]
      creates '/usr/local/bin/stunnel'
    end

    link '/usr/bin/stunnel' do
      to '/usr/local/bin/stunnel'
    end
  else
    new_resource.packages.each do |pkg|
      package pkg
    end
  end

  user 'stunnel4' do
    home '/var/run/stunnel4'
    system true
    shell '/bin/false'
    manage_home true
    not_if { platform_family?('debian') }
  end

  directory '/etc/stunnel' do
    owner 'root'
    group 'root'
    mode '0755'
  end
end

action :delete do
  new_resource.packages.each do |pkg|
    package pkg do
      action :remove
    end
  end

  link '/usr/bin/stunnel' do
    action :delete
    only_if { ::File.symlink?('/usr/bin/stunnel') }
  end
end
