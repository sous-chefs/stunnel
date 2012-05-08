package "stunnel"

service "stunnel4" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

bash "Create SSL Certificates" do
	# Steps
	# =====
	#	1) Create an SSL private key.
	#	2) Create certificate signing request (CSR).
	#
	# @param node[:fqdn]: The hostname or fqdn of the server.
	# @param node[:stunnel][:server_ssl_req]
	
	cwd "/etc/ssl"
    creates "/etc/ssl/certs/stunnel.pem"
	code <<-EOH
	umask 077
	openssl genrsa 2048 > private/#{node[:fqdn]}.key
	openssl req -subj "#{node[:stunnel][:server_ssl_req]}" -new -x509 -nodes -sha1 -days 3650 -key private/#{node[:fqdn]}.key > certs/#{node[:fqdn]}.crt
	cat private/#{node[:fqdn]}.key certs/#{node[:fqdn]}.crt > certs/stunnel.pem
	EOH
end

file "/etc/default/stunnel4" do
    content """ENABLED=1
    FILES='/etc/stunnel/*.conf'
    OPTIONS=''
    """
end
