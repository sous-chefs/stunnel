
httpd_service 'hello' do
  action [:create, :start]
end

httpd_config 'hello' do
  instance 'hello'
  source 'hello.erb'
  notifies :restart, 'httpd_service[hello]'
end

file '/var/www/index.html' do
  content 'hello there\n'
  action :create
end
