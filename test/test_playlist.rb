require File.dirname(__FILE__) + '/common'
include Rdio

class TestPlaylist < RdioTestCase

  def test_big_icon
    playlist = Playlist.get 'p3917','bigIcon'
    long_url = 'http://m.rdio.com/_is/?aid=154083,211660&w=600&h=600'
    assert_equal long_url,playlist.big_icon
  end

  def test_track_keys
    playlist = Playlist.get 'p3917','trackKeys'
    track_keys = playlist.track_keys
    assert_not_nil track_keys.index 't1851082t2560085'
  end

  def test_collaborating
    playlist = Playlist.get 'p158060'
    playlist.collaborating = true
  end

  def test_collaboration_mode
    playlist = Playlist.get  'p158060'
    playlist.collaboration_mode = 1
  end

  def test_track_keys
    playlist = Playlist.get 'p158060','trackKeys'
    track_keys = ['t5734430','t5734492']
    playlist.order = track_keys
  end 

  def test_set_fields
    playlist = Playlist.get 'p158060'
    playlist.set_fields 'the name','the description'
  end

end
