require 'serverspec'
require 'net/http'
require 'uri'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "Stunnel Client" do
  it "returns an nginx reponse" do
    uri = URI('http://localhost:9090')
    response = Net::HTTP.get_response(uri)
    expect(response.to_hash['server'].first).to match(/nginx/)
  end
end
