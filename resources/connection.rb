# frozen_string_literal: true

provides :stunnel_connection
unified_mode true

default_action :create

property :service_name, String, name_property: true
property :connect, [String, Integer], required: true
property :accept, [String, Integer], required: true
property :cafile, String
property :cert, String
property :key, String
property :verify, Integer
property :verify_chain, [true, false]
property :timeout_close, [true, false]
property :client, [true, false]
property :protocol, String
property :options, Hash
property :config_file, String, default: '/etc/stunnel/conf.d'

action :create do
  directory new_resource.config_file do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end

  file ::File.join(new_resource.config_file, "#{new_resource.service_name}.conf") do
    content render_service_config
    owner 'root'
    group 'root'
    mode '0644'
  end
end

action :delete do
  file ::File.join(new_resource.config_file, "#{new_resource.service_name}.conf") do
    action :delete
  end
end

action_class do
  def render_service_config
    lines = ["[#{new_resource.service_name}]"]
    lines << "connect = #{new_resource.connect}"
    lines << "accept = #{new_resource.accept}"
    lines << "key = #{new_resource.key}" if new_resource.key
    lines << "cert = #{new_resource.cert}" if new_resource.cert
    lines << "CAfile = #{new_resource.cafile}" if new_resource.cafile
    lines << "verify = #{new_resource.verify}" if new_resource.verify
    lines << "verifyChain = #{new_resource.verify_chain ? 'yes' : 'no'}" unless new_resource.verify_chain.nil?
    lines << "TIMEOUTclose = #{new_resource.timeout_close ? 1 : 0}" unless new_resource.timeout_close.nil?
    lines << "client = #{new_resource.client ? 'yes' : 'no'}" unless new_resource.client.nil?
    lines << "protocol = #{new_resource.protocol}" if new_resource.protocol
    if new_resource.options
      new_resource.options.each do |k, v|
        lines << "#{k} = #{v}"
      end
    end
    lines.join("\n") + "\n"
  end
end
