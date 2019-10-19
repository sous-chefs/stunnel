#
# Cookbook:: test_stunnel
# Recipe:: default
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


stunnel_connection 'server' do
  accept 8080
  connect 80
  notifies :restart, 'service[stunnel]'
end

stunnel_connection 'client' do
  accept 9090
  connect 'localhost:8080'
  client true
  notifies :restart, 'service[stunnel]'
end
