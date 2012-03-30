$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start
require 'tickspot'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  #
end

def fake_post(resource, params = {})
  params.merge!(:email => 'bar@example.com', :password => 'bar-secret')
  stub_request(:post, "https://bar.tickspot.com/api/#{resource}"
              ).with(:query => params
              ).to_return(:body => fixture_file("#{resource}.xml"), :status => 200, :headers => {'Content-Type' => 'application/xml'})
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end
