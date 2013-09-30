case node.platform_family
when 'debian'
  default[:stunnel][:packages] = %w(stunnel4)
else
  default[:stunnel][:packages] = %w(stunnel)
end

default[:stunnel][:service_name] = 'stunnel4'
default[:stunnel][:ssl_dir] = '/etc/ssl'
default[:stunnel][:server_ssl_req]  = "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/CN=#{node[:fqdn]}/emailAddress=root@#{node[:fqdn]}"
default[:stunnel][:cert_fqdn] = node[:fqdn]

default[:stunnel][:use_chroot] = false
default[:stunnel][:chroot_path] = "/usr/var/lib/stunnel"
default[:stunnel][:pidfile] = "/var/run/stunnel/stunnel.pid"
default[:stunnel][:user] = "root"
default[:stunnel][:group] = "root"

default[:stunnel][:https][:enabled] = false
default[:stunnel][:https][:accept_port] = "443"
default[:stunnel][:https][:connect_port] = "81"

default[:stunnel][:client_mode] = true
default[:stunnel][:failover] = 'rr'

default[:stunnel][:ssl_version] = 'all'
default[:stunnel][:ssl_options] = 'NO_SSLv2'
default[:stunnel][:socket_tunings] = %w(l:TCP_NODELAY=1 r:TCP_NODELAY=1)
default[:stunnel][:compression] = nil # zlib
default[:stunnel][:debug] = 4 # warning
default[:stunnel][:output] = '/var/log/stunnel/stunnel.log'
default[:stunnel][:delay] = nil # only available in newer stunnel versions

# key value pair mapping for default var file
default[:stunnel][:default][:enabled] = 1
default[:stunnel][:default][:files] = '/etc/stunnel/*.conf'
default[:stunnel][:default][:options] = ''

default[:stunnel][:services] = {}

# ssl verification options
default[:stunnel][:verify] = nil
default[:stunnel][:ca_path] = nil
default[:stunnel][:ca_file] = nil
default[:stunnel][:crl_path] = nil
default[:stunnel][:crl_file] = nil

# timeouts
default[:stunnel][:timeout_connect] = nil
default[:stunnel][:session_cache_timeout] = nil
default[:stunnel][:session_cache_size] = nil
