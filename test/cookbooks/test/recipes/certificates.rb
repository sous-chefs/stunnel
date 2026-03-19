# frozen_string_literal: true

apt_update

stunnel_install 'default'

stunnel_config 'default' do
  client_mode true
end

certificates = data_bag_item('stunnel', 'certificates')

cert_dir = '/etc/stunnel/certificates'
directory cert_dir do
  recursive true
  owner 'root'
  group 'root'
  mode '0755'
end

ca_pem = File.join(cert_dir, 'ca.pem')
file ca_pem do
  content certificates['ca']
  owner 'root'
  group 'root'
  mode '0700'
end

cert_pem = File.join(cert_dir, 'cert.pem')
file cert_pem do
  content certificates['server_cert']
  owner 'root'
  group 'root'
  mode '0700'
end

cert_client_pem = File.join(cert_dir, 'cert-client.pem')
file cert_client_pem do
  content certificates['client_cert']
  owner 'root'
  group 'root'
  mode '0700'
end

stunnel_connection 'server' do
  accept 8080
  connect 80
  cafile ca_pem
  cert cert_pem
  verify 2
end

stunnel_connection 'client' do
  accept 9090
  connect 'localhost:8080'
  cafile ca_pem
  cert cert_client_pem
  verify 2
  client true
end

stunnel_service 'stunnel'
