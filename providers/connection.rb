#
# Cookbook Name:: stunnel
# Providers:: connection
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

def load_current_resource
  node[:stunnel][:services] ||= {}
  unless(new_resource.service_name)
    new_resource.service_name new_resource.name
  end
end

action :create do
  hsh = Mash.new(
    :connect => new_resource.connect,
    :accept => new_resource.accept,
    :cafile => new_resource.cafile,
    :cert => new_resource.cert,
    :verify => new_resource.verify,
    :timeout_close => new_resource.timeout_close,
    :client => new_resource.client
  )
  exist = Mash.new(node[:stunnel][:services][new_resource.service_name])
  if(exist != hsh)
    node.set[:stunnel][:services][new_resource.service_name] = hsh
    new_resource.updated_by_last_action(true)
  end
end

action :delete do
  serv_data = Mash.new(node[:stunnel][:services])
  if(serv_data.delete(new_resource.service_name))
    node.set[:stunnel][:services] = serv_data
    new_resource.updated_by_last_action(true)
  end
end
