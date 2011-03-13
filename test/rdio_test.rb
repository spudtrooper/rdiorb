require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rdio'

@@the_api = nil

def api
  if not @@the_api
    key = ENV['RDIO_KEY']
    secret = ENV['RDIO_SECRET']
    @@the_api = Rdio::Api.new key,secret
  end
  return @@the_api
end
