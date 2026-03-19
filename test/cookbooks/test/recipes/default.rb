# frozen_string_literal: true

apt_update

stunnel_install 'default'

stunnel_config 'default' do
  client_mode true
end

stunnel_connection 'server' do
  accept 8080
  connect 80
end

stunnel_connection 'client' do
  accept 9090
  connect 'localhost:8080'
  client true
end

stunnel_service 'stunnel'
