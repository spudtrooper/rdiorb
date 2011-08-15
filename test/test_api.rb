require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestUser < RdioTestCase

  def test_find_user_by_email
    email = 'jeff@jeffpalm.com'
    user = Rdio::api.findUserByEmail email
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_find_user_by_vanity_name
    name = 'spudtrooper'
    user = Rdio::api.findUserByVanityName name
    assert_not_nil user
    assert_equal 'Jeffrey',user.first_name
    assert_equal 'Palm',user.last_name
  end

  def test_get_string
    albums = Rdio::api.get 'a446068',Album,'tracks'
    album = albums[0]
    tracks = album.tracks
    assert_equal 10,tracks.length
    tracks.each do |t|
      assert_equal Track,t.class
    end
  end

  def test_get_string_array
    albums = Rdio::api.get 'a446068',Album,['tracks']
    album = albums[0]
    tracks = album.tracks
    assert_equal 10,tracks.length
    tracks.each do |t|
      assert_equal Track,t.class
    end
  end

  
end
