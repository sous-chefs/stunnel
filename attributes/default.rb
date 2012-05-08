default[:stunnel][:server_ssl_req]  = "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/CN=#{node.fqdn}/emailAddress=root@#{node.fqdn}"

default[:stunnel][:certificate_path] = "/etc/ssl/certs/#{node[:fqdn]}.crt"
default[:stunnel][:key_path] = "/etc/ssl/private/#{node[:fqdn]}.key"

default[:stunnel][:use_chroot] = false
default[:stunnel][:chroot_path] = "/usr/var/lib/stunnel"
default[:stunnel][:pidfile] = "/tmp/stunnel.pid"
default[:stunnel][:user] = "root"
default[:stunnel][:group] = "root"

default[:stunnel][:https][:enabled] = true
default[:stunnel][:https][:accept_port] = "443"
default[:stunnel][:https][:connect_port] = "81"
