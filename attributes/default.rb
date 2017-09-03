#
# Cookbook Name:: stunnel
# Attributes:: default
#
# Copyright 2016 Aetrion, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'debian'
  default['stunnel']['packages'] = %w(stunnel4)
  default['stunnel']['daemon'] = 'stunnel4'
  default['stunnel']['ssl-devel'] = 'libssl-dev'
else
  default['stunnel']['packages'] = %w(stunnel)
  default['stunnel']['daemon'] = 'stunnel'
  default['stunnel']['ssl-devel'] = 'openssl-devel'
end

default['stunnel']['service_name'] = 'stunnel4'
default['stunnel']['ssl_dir'] = '/etc/ssl'
default['stunnel']['server_ssl_req'] = "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/CN=#{node['fqdn']}/emailAddress=root@#{node['fqdn']}"
default['stunnel']['cert_fqdn'] = node['fqdn']

default['stunnel']['install_method'] = 'package'
default['stunnel']['source_download'] = 'ftp://ftp.stunnel.org/stunnel/archive/4.x/stunnel-4.56.tar.gz'
default['stunnel']['source_checksum'] = '9cae2cfbe26d87443398ce50d7d5db54e5ea363889d5d2ec8d2778a01c871293'

default['stunnel']['use_chroot'] = false
default['stunnel']['chroot_path'] = '/usr/var/lib/stunnel'
default['stunnel']['pidfile'] = '/tmp/stunnel.pid'
default['stunnel']['user'] = 'root'
default['stunnel']['group'] = 'root'
default['stunnel']['ulimit'] = nil

default['stunnel']['https']['enabled'] = false
default['stunnel']['https']['accept_port'] = '443'
default['stunnel']['https']['connect_port'] = '81'

default['stunnel']['client_mode'] = true

default['stunnel']['fips'] = nil
default['stunnel']['ssl_version'] = 'all'
default['stunnel']['ssl_options'] = 'NO_SSLv2'
default['stunnel']['ciphers'] = nil
default['stunnel']['socket_tunings'] = %w(l:TCP_NODELAY=1 r:TCP_NODELAY=1)
default['stunnel']['compression'] = nil # zlib
default['stunnel']['debug'] = 4 # warning
default['stunnel']['output'] = '/var/log/stunnel.log'

# key value pair mapping for default var file
default['stunnel']['default']['enabled'] = 1
default['stunnel']['default']['files'] = '/etc/stunnel/*.conf'
default['stunnel']['default']['options'] = ''

default['stunnel']['services'] = {}
