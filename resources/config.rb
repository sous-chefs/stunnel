# frozen_string_literal: true

provides :stunnel_config
unified_mode true

default_action :create

property :config_file, String, default: '/etc/stunnel/stunnel.conf'
property :ssl_version, String, default: 'all'
property :ssl_options, String
property :ciphers, String
property :certificate_path, String
property :key_path, String
property :use_chroot, [true, false], default: false
property :chroot_path, String, default: '/usr/var/lib/stunnel'
property :pidfile, String, default: '/tmp/stunnel.pid'
property :user, String, default: 'root'
property :group, String, default: 'root'
property :client_mode, [true, false], default: true
property :fips, [true, false]
property :debug, [Integer, String], default: 4
property :output, String, default: '/var/log/stunnel.log'
property :socket_tunings, Array, default: %w(l:TCP_NODELAY=1 r:TCP_NODELAY=1)
property :compression, String
property :config_options, Array
property :services, Hash, default: {}
property :cookbook, String, default: 'stunnel'

action :create do
  directory ::File.dirname(new_resource.config_file) do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end

  if new_resource.use_chroot
    directory new_resource.chroot_path do
      owner new_resource.user
      group new_resource.group
      recursive true
    end
  end

  directory ::File.join(::File.dirname(new_resource.config_file), 'conf.d') do
    owner 'root'
    group 'root'
    mode '0755'
  end

  template new_resource.config_file do
    source 'stunnel.conf.erb'
    cookbook new_resource.cookbook
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      certificate_path: new_resource.certificate_path,
      key_path: new_resource.key_path,
      ssl_version: new_resource.ssl_version,
      ssl_options: new_resource.ssl_options,
      ciphers: new_resource.ciphers,
      use_chroot: new_resource.use_chroot,
      chroot_path: new_resource.chroot_path,
      user: new_resource.user,
      group: new_resource.group,
      pidfile: new_resource.pidfile,
      socket_tunings: new_resource.socket_tunings,
      compression: new_resource.compression,
      config_options: new_resource.config_options,
      debug: new_resource.debug,
      output: new_resource.output,
      fips: new_resource.fips,
      client_mode: new_resource.client_mode,
      services: new_resource.services
    )
  end
end

action :delete do
  file new_resource.config_file do
    action :delete
  end
end
