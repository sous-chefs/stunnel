# stunnel

[![Cookbook Version](https://img.shields.io/cookbook/v/stunnel.svg)](https://supermarket.chef.io/cookbooks/stunnel)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/chef-stunnel/master.svg)](https://circleci.com/gh/sous-chefs/chef-stunnel)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Chef cookbook to install and configure stunnel

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

- Chef 13

## Platform Support

- Ubuntu 14.04+
- CentOS 6.9+

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
default['stunnel']['default']['files'] = '/etc/stunnel/-.conf'
default['stunnel']['default']['options'] = ''

# certificate/key is needed in server mode and optional in client mode
default['stunnel']['certificate_path'] = nil # /etc/pki/stunnel/cert.pem
default['stunnel']['key_path'] = nil # /etc/pki/stunnel/key.pem
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

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
