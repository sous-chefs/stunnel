# stunnel

Chef cookbook to install and configure stunnel

## LWRP

An LWRP is provided for defining stunnel connections. As a client:
```ruby
include_recipe 'stunnel'

stunnel_connection 'random_service' do
  client true
  connect "#{rnd_srv_node[:ipaddress]}:#{rnd_srv_node[:random_service][:port]}"
  accept node[:random_service][:local_accept_port]
  notifies :restart, 'service[stunnel]'
end
```

As a server:
```ruby
include_recipe 'stunnel'

stunnel_connection 'random_service' do
  client false
  accept node[:random_service][:tunnel_port]
  connect node[:random_service][:port]
  notifies :restart, 'service[stunnel]'
end
```

## Attributes

Lots of configurable attributes:

```ruby
default[:stunnel][:packages] = %w(stunnel4)
default[:stunnel][:service_name] = 'stunnel4'

default[:stunnel][:ssl_dir] = '/etc/ssl'
default[:stunnel][:server_ssl_req]  = "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/CN=#{node.fqdn}/emailAddress=root@#{node.fqdn}"
default[:stunnel][:cert_fqdn] = node[:fqdn]

default[:stunnel][:use_chroot] = false
default[:stunnel][:chroot_path] = "/usr/var/lib/stunnel"
default[:stunnel][:pidfile] = "/tmp/stunnel.pid"
default[:stunnel][:user] = "root"
default[:stunnel][:group] = "root"

# Maximum open file descriptors, will determine the maximum open connections
# Stunnel may use anywhere from one to four file descriptors per connection.
default[:stunnel][:max_fd] = 1024

default[:stunnel][:https][:enabled] = false
default[:stunnel][:https][:accept_port] = "443"
default[:stunnel][:https][:connect_port] = "81"

default[:stunnel][:ssl_version] = 'all'
default[:stunnel][:ssl_options] = 'NO_SSLv2'
default[:stunnel][:socket_tunings] = %w(l:TCP_NODELAY=1 r:TCP_NODELAY=1)
default[:stunnel][:compression] = nil # zlib
default[:stunnel][:debug] = nil # 3
default[:stunnel][:output] = '/var/log/stunnel.log'

# key value pair mapping for default var file
default[:stunnel][:default][:enabled] = 1
default[:stunnel][:default][:files] = '/etc/stunnel/*.conf'
default[:stunnel][:default][:options] = ''

# optionally you can use attributes instead of the LWRPs above
node[:stunnel][:services][:random_service][:accept]  = ipaddr:port
node[:stunnel][:services][:random_service][:connect] = ipaddr:port
node[:stunnel][:services][:random_service][:client]  = true

# Certificate, private key, DH params
node[:stunnel][:certificates][:stunnel] = "-----BEGIN PRIVATE KEY-----..."
# Acceptable certificates to be used at verify_level 3
node[:stunnel][:certificates][:certs]   = "-----BEGIN CERTIFICATE-----..."
# Will be written to /etc/stunnel/foo.pem
node[:stunnel][:certificates][:foo] = "-----BEGIN ..."
```

## Infos
* Repository: https://github.com/hw-cookbooks/stunnel
* IRC: Freenode @ #heavywater
