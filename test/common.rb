require 'rubygems'
require 'test/unit'
include Test::Unit
require File.dirname(__FILE__) + '/../lib/rdio'

class TestCase
  def assert_not_nil(o)
    if not o
      assert false,'Should not be nil'
    end
  end

  def assert_length_at_least(num,arr,thing)
    if arr.length < num
      assert false,"Not enough #{thing}s: #{arr.length} < #{num}"
    end
  end

  def assert_at_least(num,val,thing=nil)
    if val < num
      assert false,"#{thing} #{val} must be at least #{num}"
    end
  end
end

class RdioTestCase < TestCase

  ACCESS_TOKEN_FILE = '.rdio_access_token'

  def setup
    Rdio.reset
    if not File.exist? ACCESS_TOKEN_FILE
      raise '.access_token must be a file holding ' +
        'the string value of an authorized ' +
        'access token created from Marshal.dump'
    end
    token = Marshal.load File.new ACCESS_TOKEN_FILE
    Rdio.init_with_token token
    other_setup
  end

  def other_setup
    # nothing
  end

  def teardown
    Rdio.reset
  end

  def test_default_test
    assert true,''
  end
  
end

# Turn off this specific warning for tests:
#
#   Couldn't find symbol: radio_key => rr31531 for type: Rdio::Artist
#
Rdio::log_couldnt_find_symbols = false
