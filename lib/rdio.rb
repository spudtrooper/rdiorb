$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# core

# stdlib
require 'logger'

# third party

# internal requires
require 'rdio/base'
require 'rdio/api'
require 'rdio/oauth'
require 'rdio/datatypes'
require 'rdio/types'

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
    def log(str)
      logger.debug { str }
    end
  end
  self.debug = false
  self.log_json = false
  self.log_methods = false
  self.log_symbols = false

  @logger ||= ::Logger.new(STDERR)
  @api = nil

  def self.version
    VERSION
  end

  # Initializes and returns the shared Api instance and overwrites the
  # existing one.
  def self.init(key,secret)
    @api = Api.new key,secret
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

# Silly syntax so you can say Rd::io...blah...blah...blah
module Rd
  
  # Returns the shared Rdio::Api instance from Rdio::api
  def self.io
    Rdio::api
  end

end
