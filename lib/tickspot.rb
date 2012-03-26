require "tickspot/version"

module Tickspot
  
  class << self
    attr_accessor :company, :email, :password

    # config/initializers/tickspot.rb (for instance)
    #
    # Tickspot.configure do |config|
    #   config.company = 'acme'
    #   config.email = 'wilie@acme.com'
    #   config.password = 'secret'
    # end
    #
    # elsewhere
    #
    # client = Tickspot::Client.new
    def configure
      yield self
      true
    end
  end
  
  # autoload :Api,     "tickspot/api"
  autoload :Client,  "tickspot/client"
  # autoload :Version, "tickspot/version"
end
