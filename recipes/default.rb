#
# Cookbook Name:: stunnel
# Recipes:: default
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

if node['stunnel']['install_method'] == 'source'
  include_recipe 'stunnel::source'
else
  node['stunnel']['packages'].each do |s_pkg|
    package s_pkg
  end
end

# Create directory to hold the pid inside the chroot jail
directory node['stunnel']['chroot_path'] do
  owner node['stunnel']['user']
  group node['stunnel']['group']
  recursive true
  action :create
  only_if { node['stunnel']['use_chroot'] }
end

user 'stunnel4' do
  home '/var/run/stunnel4'
  system true
  shell '/bin/false'
  manage_home true
  not_if { node['platform_family'] == 'debian' }
end

template '/etc/init.d/stunnel4' do
  source 'init-stunnel4.erb'
  mode 0755
  variables(
    ulimit: node['stunnel']['ulimit'],
    daemon: node['stunnel']['daemon']
  )
end

ruby_block 'stunnel.conf notifier' do
  block do
    true
  end
  notifies :create, 'template[/etc/stunnel/stunnel.conf]', :delayed
end

template '/etc/stunnel/stunnel.conf' do
  source 'stunnel.conf.erb'
  mode 0644
  action :nothing
  notifies :reload, 'service[stunnel]', :delayed
end

template '/etc/default/stunnel4' do
  source 'stunnel.default.erb'
  mode 0644
end

service 'stunnel' do
  service_name node['stunnel']['service_name']
  supports restart: true, reload: true
  action [:enable, :start]
  not_if do
    node['stunnel']['services'].empty?
  end
end
