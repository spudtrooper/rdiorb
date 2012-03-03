require 'rubygems'
require 'oauth'

module Rdio

  # ----------------------------------------------------------------------
  # Performs oob OAuth authentication based on a key and secret
  # ----------------------------------------------------------------------
  class RdioOAuth

    SITE = 'http://api.rdio.com'

    attr_accessor :key, :secret

    # string[url] -> string
    #
    # Set this to allow a different way to enter the pin found for
    # authorization.  By default it will open a browser and repeatedly
    # ask the user for input from the console.
    #
    attr_accessor :get_pin

    def initialize(key,secret)
      @key = key
      @secret = secret
      @get_pin = lambda do |url|

        # Try to open using launchy, then if this doesn't work use
        # system open
        begin
          require 'rubygems'
          require 'launchy'
          Launchy.open url
        rescue Exception => e
          Rdio::logger.error e
          Rdio::logger.info 'Install the \'launchy\' gem to avoid this error'
          Rdio::logger.info 'Trying system \'open\''
          system 'open',url
        end

        oauth_verifier = nil
        while not oauth_verifier or oauth_verifier == ''
          print 'Enter the 4-digit PIN> '
          STDOUT.flush
          oauth_verifier = gets.strip
        end
        return oauth_verifier
      end
    end

    # boolean[requires_auth] -> AccessToken
    #
    # Returns an appropriate oob access token. If requires_auth is
    # true we'll return one needed for authenticated requests.
    # Otherwise (default), we'll return one needed for unauthenticated
    # requests.
    #
    def access_token(requires_auth=false)
      requires_auth ? access_token_auth : access_token_no_auth
    end

    private

    def access_token_no_auth
      consumer = OAuth::Consumer.new @key, @secret, {:site => SITE}
      consumer.http.read_timeout = 600
      return OAuth::AccessToken.new consumer
    end

    def access_token_auth
      consumer =
        OAuth::Consumer.new(@key,@secret,
                            {:site => SITE,
                              :request_token_path => "/oauth/request_token",
                              :authorize_path => "/oauth/authorize",
                              :access_token_path => "/oauth/access_token",
                              :http_method => :post})
      consumer.http.read_timeout = 600
      request_token = consumer.get_request_token({:oauth_callback => 'oob'})
      url = 'https://www.rdio.com/oauth/authorize?oauth_token=' +
        request_token.token.to_s
      oauth_verifier = @get_pin.call url
      return request_token.get_access_token({:oauth_verifier => oauth_verifier})
    end
  end

end
