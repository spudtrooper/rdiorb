require File.dirname(__FILE__) + '/common'
include Rdio

class TestAccessToken < Test::Unit::TestCase

  ACCESS_TOKEN_FILE = '.rdio_access_token'

  def test_current
    if not File.exist? ACCESS_TOKEN_FILE
      raise '.access_token must be a file holding ' +
        'the string value of an authorized ' +
        'access token created from Marshal.dump'
    end
    token = Marshal.load File.new ACCESS_TOKEN_FILE
    Rdio.init_with_token token
    user = User.current
    assert_not_nil user
  end
  
end
