require 'spec_helper'
require 'net/http'
require 'uri'

describe 'Stunnel Client' do
  it 'returns an nginx reponse' do
    uri = URI('http://localhost:9090')
    response = Net::HTTP.get_response(uri)
    expect(response.to_hash['server'].first).to match(/nginx/)
  end
end
