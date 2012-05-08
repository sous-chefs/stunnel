default[:stunnel][:server_ssl_req]  = "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/" +
	"CN=#{node.fqdn}/emailAddress=root@#{node.fqdn}"