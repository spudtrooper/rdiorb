require File.dirname(__FILE__) + '/common'
include Rdio

class TestPlaylist < RdioTestCase

  @playlist = nil
  @playlist_key = nil

  def other_setup
    name = 'test playlist'
    desc = 'description for test playlist'
    tracks = [Track.get('t5483181')]
    playlist = Playlist.create name,desc,tracks,'trackKeys'
    assert_not_nil playlist
    @playlist = playlist
    @playlist_key = playlist.key
  end

  def other_teardown
    @playlist.delete
  end

  def test_big_icon
    playlist = Playlist.get 'p3917','bigIcon'
    long_url_start = 'http://m.rdio.com/_is/?aid=154083'
    assert_not_nil playlist.big_icon.index long_url_start
  end

  def test_track_keys
    playlist = Playlist.get 'p3917','trackKeys'
    track_keys = playlist.track_keys
    assert_not_nil track_keys.index 't1851082t2560085'
  end


   def test_collaborating
     playlist = Playlist.get @playlist_key
     playlist.collaborating = true
   end

  def test_collaboration_mode
    playlist = Playlist.get  @playlist_key
    playlist.collaboration_mode = 1
  end

  def test_track_keys
    playlist = Playlist.get @playlist_key,'trackKeys'
    track_keys = ['t5734430','t5734492']
    playlist.order = track_keys
  end

  def test_set_fields
    playlist = Playlist.get @playlist_key
    playlist.set_fields 'the name','the description'
  end

end
