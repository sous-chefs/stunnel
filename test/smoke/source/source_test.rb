describe command('curl -I localhost:9090') do
  its('stdout') { should match(/nginx/) }
end
