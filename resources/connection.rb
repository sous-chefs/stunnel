#
# Cookbook Name:: stunnel
# Resources:: connection
#
# Copyright 2016-2017 Aetrion, LLC dba DNSimple
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

default_action :create

property :service_name, String, name_property: true
property :connect, required: true
property :accept, required: true
property :cafile, String
property :cert, String
property :key, String
property :verify, Integer
property :verify_chain, [true, false]
property :timeout_close, [true, false]
property :client, [true, false]

action :create do
  hsh = Mash.new(
    connect: new_resource.connect,
    accept: new_resource.accept,
    cafile: new_resource.cafile,
    cert: new_resource.cert,
    key: new_resource.key,
    verify: new_resource.verify,
    verify_chain: new_resource.verify_chain,
    timeout_close: new_resource.timeout_close,
    client: new_resource.client
  )
  exist = Mash.new(node['stunnel']['services'][new_resource.service_name])
  if exist != hsh
    converge_by 'update_services' do
      node.default['stunnel']['services'][new_resource.service_name] = hsh
    end
  end
end

action :delete do
  serv_data = Mash.new(node['stunnel']['services'])
  if serv_data.delete(new_resource.service_name)
    converge_by 'update_services' do
      node.default['stunnel']['services'] = serv_data
    end
  end
end
