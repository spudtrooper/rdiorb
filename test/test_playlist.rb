require File.dirname(__FILE__) + '/common'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestPlaylist < Test::Unit::TestCase

  def test_big_icon
    playlist = Playlist.get 'p3917','bigIcon'
    assert_equal 'http://m.rdio.com/_is/?aid=154083,211660&w=600&h=600',playlist.big_icon
  end

  def test_track_keys
    playlist = Playlist.get 'p3917','trackKeys'
    track_keys = playlist.track_keys
    assert_not_nil track_keys.index 't1851082t2560085'
  end

end
