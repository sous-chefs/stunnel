node[:stunnel][:packages].each do |s_pkg|
  package s_pkg
end

# Create directory to hold the pid inside the chroot jail
if(node[:stunnel][:use_chroot])
  directory "#{node[:stunnel][:chroot_path]}" do
    owner node[:stunnel][:user]
    group node[:stunnel][:group]
    recursive true
    action :create
  end
end

template "/etc/stunnel/stunnel.conf" do
  source "stunnel.conf.erb"
  mode 0644
end

template "/etc/default/stunnel4" do
  source "stunnel.default.erb"
  mode 0644
end

service "stunnel" do
  service_name node[:stunnel][:service_name]
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
