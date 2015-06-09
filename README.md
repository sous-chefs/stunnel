# stunnel

Chef cookbook to install and configure stunnel

## LWRP

An LWRP is provided for defining stunnel connections. As a client:
```ruby
include_recipe 'stunnel'

stunnel_connection 'random_service' do
  connect "#{rnd_srv_node[:ipaddress]}:#{rnd_srv_node[:random_service][:port]}"
  accept node[:random_service][:local_accept_port]
  notifies :restart, 'service[stunnel]'
end
```

As a server:
```ruby
include_recipe 'stunnel::server'

stunnel_connection 'random_service' do
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
default[:stunnel][:server_ssl_req]  = "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/CN=#{node[:fqdn]}/emailAddress=root@#{node[:fqdn]}"
default[:stunnel][:cert_fqdn] = node[:fqdn]

default[:stunnel][:use_chroot] = false
default[:stunnel][:chroot_path] = "/usr/var/lib/stunnel"
default[:stunnel][:pidfile] = "/tmp/stunnel.pid"
default[:stunnel][:user] = "root"
default[:stunnel][:group] = "root"

default[:stunnel][:https][:enabled] = false
default[:stunnel][:https][:accept_port] = "443"
default[:stunnel][:https][:connect_port] = "81"

default[:stunnel][:client_mode] = true

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

# certificate/key is needed in server mode and optional in client mode 
default[:stunnel][:certificate_path] = nil # /etc/pki/stunnel/cert.pem
default[:stunnel][:key_path] = nil # /etc/pki/stunnel/key.pem
```

## ChefSpec Matchers

A set of ChefSpec matchers is included, for unit testing with ChefSpec. To illustrate:

Recipe code:

```ruby
stunnel_connection 'haproxy_ssl' do
  accept    '443'
  connect   '8443'
end
```

And the matching spec:

```ruby
it 'should create stunnel_connection haproxy_ssl' do
  expect(chef_run).to create_stunnel_connection('haproxy_ssl').with(
    accept:  '443',
    connect: '8443'
  )
end
```

You can also make assertions for notifying other resources:

```ruby
it 'should notify stunnel to restart on changes to stunnel_connection[haproxy_ssl]' do
  resource = chef_run.stunnel_connection('haproxy_ssl')
  expect(resource).to notify('service[stunnel]').to(:restart)
end
```

A matcher for the delete action is also available:

```ruby
it 'should delete stunnel_connection haproxy_ssl' do
  expect(chef_run).to delete_stunnel_connection('haproxy_ssl')
end
```

## Infos
* Repository: https://github.com/hw-cookbooks/stunnel
* IRC: Freenode @ #heavywater
