require 'rubygems'
require 'oauth'
require 'open-uri'

module Rdio

  # ----------------------------------------------------------------------
  # Performs OAuth authentication based on a key and secret
  # ----------------------------------------------------------------------
  class RdioOAuth
    def initialize(key,secret)
      @key = key
      @secret = secret
    end

    def access_token

      consumer_key = @key
      consumer_secret = @secret
      consumer = 
        OAuth::Consumer.new(consumer_key, 
                            consumer_secret,
                            {:site => 'http://api.rdio.com',
                              :request_token_path => "/oauth/request_token",
                              :authorize_path => "/oauth/authorize",
                              :access_token_path => "/oauth/access_token",
                              :http_method => :post})

      request_token = consumer.get_request_token({:oauth_callback => 'oob'})
      url = 'https://www.rdio.com/oauth/authorize?oauth_token=' + 
        request_token.token.to_s
      system 'open',url

      oauth_verifier = nil
      while not oauth_verifier or oauth_verifier == ''
        print 'Enter the PIN> '
        oauth_verifier = gets.strip
      end
      request_token.get_access_token({:oauth_verifier => 
                                       oauth_verifier})
    end
  end

end
