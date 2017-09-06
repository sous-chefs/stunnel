# stunnel

[![Build Status](https://travis-ci.org/dnsimple/chef-stunnel.svg?branch=master)](https://travis-ci.org/dnsimple/chef-stunnel)

Chef cookbook to install and configure stunnel

## Requirements

* Chef 12.6+

## Platform Support

* Ubuntu 14.04+
* CentOS 6.9+

## Resources

An `stunnel_connection` resource is provided for defining stunnel connections. As a client:
```ruby
include_recipe 'stunnel'

stunnel_connection 'random_service' do
  connect "#{rnd_srv_node['ipaddress']}:#{rnd_srv_node['random_service']['port']}"
  accept node['random_service']['local_accept_port']
  notifies :restart, 'service[stunnel]'
end
```

As a server:
```ruby
include_recipe 'stunnel::server'

stunnel_connection 'random_service' do
  accept node['random_service']['tunnel_port']
  connect node['random_service']['port']
  notifies :restart, 'service[stunnel]'
end
```

## Attributes

Lots of configurable attributes:

```ruby
default['stunnel']['install_method'] = 'package'  # the other valid option is 'source'

default['stunnel']['packages'] = %w(stunnel4)
default['stunnel']['service_name'] = 'stunnel4'

default['stunnel']['ssl_dir'] = '/etc/ssl'
default['stunnel']['server_ssl_req']  = "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/CN=#{node['fqdn']}/emailAddress=root@#{node['fqdn']}"
default['stunnel']['cert_fqdn'] = node['fqdn']

default['stunnel']['use_chroot'] = false
default['stunnel']['chroot_path'] = "/usr/var/lib/stunnel"
default['stunnel']['pidfile'] = "/tmp/stunnel.pid"
default['stunnel']['user'] = "root"
default['stunnel']['group'] = "root"
default['stunnel']['ulimit'] = nil # set to a number to add ulimit setting to init script

default['stunnel']['https']['enabled'] = false
default['stunnel']['https']['accept_port'] = "443"
default['stunnel']['https']['connect_port'] = "81"

default['stunnel']['client_mode'] = true

default['stunnel']['fips'] = nil
default['stunnel']['ssl_version'] = 'all'
default['stunnel']['ssl_options'] = 'NO_SSLv2'
default['stunnel']['socket_tunings'] = %w(l:TCP_NODELAY=1 r:TCP_NODELAY=1)
default['stunnel']['compression'] = nil # zlib
default['stunnel']['debug'] = nil # 3
default['stunnel']['output'] = '/var/log/stunnel.log'

# key value pair mapping for default var file
default['stunnel']['default']['enabled'] = 1
default['stunnel']['default']['files'] = '/etc/stunnel/*.conf'
default['stunnel']['default']['options'] = ''
```

### FIPS

FIPS mode can be enabled or disabled with the attribute `['stunnel']['fips']`. A value of nil will omit the
"fips" setting from the config file altogether, falling back to the default behavior for that version of stunnel:

- For 4.x releases FIPS defaults to on if stunnel was compiled with FIPS support.
- For 5.x releases FIPS defaults to off.


## ChefSpec Matchers

A set of ChefSpec matchers is included for unit testing with ChefSpec. These
are automatically available when you make this cookbook a dependency in your
cookbook's metadata. To illustrate:

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

## Testing Locally

To run the tests, make sure you've got the latest [ChefDK](https://downloads.chef.io/chef-dk/) along with
[Vagrant](https://www.vagrantup.com/downloads.html) then you can run `chef exec kitchen test` which will run the
entire test suite on all platforms.

## License and Authors

* Author:: [Aaron Kalin](https://github.com/martinisoft)

Copyright:: 2016-2017 Aetrion, LLC dba DNSimple

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
