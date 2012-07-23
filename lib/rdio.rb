$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# core

# stdlib
require 'logger'

# third party

module Rdio
  VERSION = '0.0.1'

  RDIO_KEY = 'RDIO_KEY'
  RDIO_SECRET = 'RDIO_SECRET'

  class << self
    attr_accessor :debug
    attr_accessor :logger
    attr_accessor :log_json
    attr_accessor :log_methods
    attr_accessor :log_symbols
    attr_accessor :log_posts
    attr_accessor :log_fill
    #
    # Specific setting to turn off warnings like the following:
    #
    #   Couldn't find symbol: radio_key => rr31531 for type: Rdio::Artist
    #
    # during tests, because we see it constantly and isn't really a
    # problem.  By default it is true, but it is turned off for all
    # tests.
    attr_accessor :log_couldnt_find_symbols

    def log(str)
      logger.debug { str }
    end
  end
  self.debug = false
  self.log_json = false
  self.log_methods = false
  self.log_symbols = false
  self.log_posts = false
  self.log_couldnt_find_symbols = false
  self.log_fill = false

  @logger ||= ::Logger.new(STDERR)
  @api = nil

  def self.version
    VERSION
  end

  # String[key] String[secret] -> Api
  #
  # Initializes and returns the shared Api instance and overwrites the
  # existing one.
  #
  def self.init(key,secret)
    @api = Api.new key,secret
  end

  # AccessToken[token] => Api
  #
  # Initializes and returns the shared Api instance from the passed in
  # access_token instance
  #
  def self.init_with_token(token)
    @api = Api.from_token token
  end

  # Resets shared API to nil
  def self.reset
    @api = nil
  end

  # Returns the shared Rdio::Api instance.  If it hasn't been set, we
  # try to construct it from thte environment
  def self.api
    return @api if @api
    key = ENV[RDIO_KEY]
    secret = ENV[RDIO_SECRET]
    if key and secret
      @api = init key,secret
    else
      msg = <<HERE
Could not construct an Api instance.  You must first call init(key,secret)
or set the following environmental variables:
- #{RDIO_KEY}
- #{RDIO_SECRET}
HERE
      raise Exception.new msg
    end
    return @api
  end
end

# internal requires
require 'rdio/base'
require 'rdio/api'
require 'rdio/oauth'
require 'rdio/datatypes'
require 'rdio/types'
require 'rdio/call'

# simple additions
require 'rdio/simple_om'
require 'rdio/simple_rdio'

# Silly syntax so you can say Rd::io.<method>
module Rd

  # Returns the shared Rdio::Api instance from Rdio::api
  def self.io
    Rdio::api
  end

end
