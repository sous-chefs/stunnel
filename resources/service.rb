# frozen_string_literal: true

provides :stunnel_service
unified_mode true

default_action :create

property :service_name, String, name_property: true
property :config_file, String, default: '/etc/stunnel/stunnel.conf'

action :create do
  systemd_unit "#{new_resource.service_name}.service" do
    content <<~UNIT
      [Unit]
      Description=SSL tunnel for network daemons
      After=network.target
      After=syslog.target

      [Service]
      Type=forking
      ExecStart=/usr/bin/stunnel #{new_resource.config_file}
      ExecStop=/bin/kill -TERM $MAINPID
      Restart=on-failure

      [Install]
      WantedBy=multi-user.target
    UNIT
    action [:create, :enable, :start]
  end
end

action :delete do
  systemd_unit "#{new_resource.service_name}.service" do
    action [:stop, :disable, :delete]
  end
end
