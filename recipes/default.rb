node[:stunnel][:packages].each do |s_pkg|
  package s_pkg
end

directory '/etc/stunnel/'

if node[:stunnel][:certificates].empty?
  execute "Create stunnel SSL Certificates" do
    command "openssl req -subj \"#{node[:stunnel][:server_ssl_req]}\" -new -nodes -x509 -out /etc/stunnel/stunnel.pem -keyout /etc/stunnel/stunnel.pem"
    creates '/etc/stunnel/stunnel.pem'
  end
else
  node[:stunnel][:certificates].each do |name, data|
    file "/etc/stunnel/#{name}.pem" do
      owner node[:stunnel][:user]
      group node[:stunnel][:group]
      mode  0600
      content data
    end
  end
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

unless(node.platform_family == 'debian')
  user 'stunnel4' do
    home '/var/run/stunnel4'
    system true
    shell '/bin/false'
    supports :manage_home => true
  end
  cookbook_file '/etc/init.d/stunnel4' do
    source 'stunnel4'
    mode 0755
  end
end

ruby_block 'stunnel.conf notifier' do
  block do
    true
  end
  notifies :create, 'template[/etc/stunnel/stunnel.conf]', :delayed
end

template "/etc/stunnel/stunnel.conf" do
  source "stunnel.conf.erb"
  mode 0644
  action :nothing
  notifies :restart, 'service[stunnel]', :delayed
end

template "/etc/default/stunnel4" do
  source "stunnel.default.erb"
  mode 0644
end

service "stunnel" do
  service_name node[:stunnel][:service_name]
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
  not_if do
    node[:stunnel][:services].empty?
  end
end
