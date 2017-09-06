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
