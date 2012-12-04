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
    :timeout_close => new_resource.timeout_close
  )
  exist = node[:stunnel][:services][new_resource.name]
  if(exist.nil? || exist != hsh)
    node.set[:stunnel][:services][new_resource.name] = hsh
    new_resource.updated_by_last_action(true)
  end
end

action :delete do
  new_resource.updated_by_last_action(
    node[:stunnel][:services].delete(new_resource.service_name)
  )
end
