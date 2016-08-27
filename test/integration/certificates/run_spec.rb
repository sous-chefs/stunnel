describe command('curl localhost:9090') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/nginx/) }
end
