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

  class << self
    attr_accessor :debug
    attr_accessor :logger
    def log(str)
      logger.debug { str }
    end
  end
  self.debug = false

  @logger ||= ::Logger.new(STDERR)

  def self.version
    VERSION
  end
end
