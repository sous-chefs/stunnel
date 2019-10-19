#
# Cookbook:: test_stunnel
# Recipe:: certificates
#
# Copyright:: 2013, Heavy Water Operations, LLC
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

include_recipe 'stunnel::server'

nginx_install 'default' do
    source 'repo'
end

certificates = data_bag_item('stunnel', 'certificates')

cert_dir = '/etc/stunnel/certificates'
directory cert_dir do
  recursive true
  owner 'root'
  group 'root'
  mode '755'
end

ca_pem = File.join(cert_dir, 'ca.pem')
file ca_pem do
  content certificates['ca']
  owner 'root'
  group 'root'
  mode '700'
end

cert_pem = File.join(cert_dir, 'cert.pem')
file cert_pem do
  content certificates['cert']
  owner 'root'
  group 'root'
  mode '700'
end

stunnel_connection 'server' do
  accept 8080
  connect 80
  cafile ca_pem
  cert cert_pem
  verify 2
  notifies :restart, 'service[stunnel]'
end

stunnel_connection 'client' do
  accept 9090
  connect 'localhost:8080'
  cafile ca_pem
  cert cert_pem
  verify 2
  client true
  notifies :restart, 'service[stunnel]'
end
