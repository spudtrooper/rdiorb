require File.dirname(__FILE__) + '/../test/rdio_test'

class TestUser < Test::Unit::TestCase

  def test_find_by_email
    email = 'jeff@jeffpalm.com'
    user = Rdio::User.find_by_email email
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_find_by_vanity_name
    name = 'spudtrooper'
    user = Rdio::User.find_by_vanity_name name
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_current
    user = Rdio::User.current
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_get_tracks_in_collection
    user = Rdio::User.current
    tracks = user.get_tracks_in_collection
    if tracks.length < 100
      assert_fail "Not enough tracks: #{tracks.length} < 100"
    end
  end
  
end
