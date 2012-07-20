require File.dirname(__FILE__) + '/common'
include Rdio

class TestPlaylist < RdioTestCase

  def test_add_delete
    name = 'test playlist'
    desc = 'description for test playlist'
    tracks = [Track.get('t5483181')]
    playlist = Playlist.create name,desc,tracks,'trackKeys'
    assert_not_nil playlist

    have = playlist.tracks
    want = tracks
    assert_equal want.length,have.length
    assert_equal want[0].name,have[0].name

    assert_equal name,playlist.name

    assert_not_nil playlist.delete
  end


end
