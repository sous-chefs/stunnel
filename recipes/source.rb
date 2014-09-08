include_recipe 'build-essential'

remote_file "#{Chef::Config[:file_cache_path]}/stunnel.tar.gz" do
  source node[:stunnel][:source_download]
  checksum node[:stunnel][:source_checksum]
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
  only_if { ::Dir.glob("#{Chef::Config[:file_cache_path]}/stunnel-*/src/stunnel").empty? }
end

link '/usr/bin/stunnel' do
  to '/usr/local/bin/stunnel'
end

