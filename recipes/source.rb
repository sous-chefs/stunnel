log 'deprecation warning' do
  message 'This is the last release to support Chef 12. 4.0.0 will be Chef 13+ only so please version pin if you need to. Please see README with upgrade instructions in the new release.'
  level :warn
end

include_recipe 'build-essential'

package node['stunnel']['ssl_devel']

remote_file "#{Chef::Config[:file_cache_path]}/stunnel.tar.gz" do
  source node['stunnel']['source_download']
  checksum node['stunnel']['source_checksum']
end

bash 'untar, configure, compile, install stunnel' do
  code <<-EOF
  tar xvzf stunnel.tar.gz
  cd stunnel-*
  ./configure
  make
  make install-exec
  EOF
  cwd Chef::Config[:file_cache_path]
  user 'root'
  creates '/usr/local/bin/stunnel'
end

link '/usr/bin/stunnel' do
  to '/usr/local/bin/stunnel'
end

