# Our systemd service uses the "simple" service type, so we need
# stunnel not to fork, and consequently have no need for a pid file.
node.override['stunnel']['foreground'] = true
node.override['stunnel']['pid'] = ''

cookbook_file '/etc/systemd/system/stunnel4.service' do
  source 'stunnel4.service'
  mode 0644
end
