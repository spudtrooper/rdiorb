require File.dirname(__FILE__) + '/common'
require File.dirname(__FILE__) + '/../lib/rdio'
include Rdio

class TestCall < Test::Unit::TestCase

  def test_get
    c = Call.new
    args = ['get', 'keys=t7609753']
    want = '{"status": "ok", "result": {"t7609753": {"baseIcon": "album/6/8/a/000000000009ba86/square-200.jpg", "canDownloadAlbumOnly": true, "artistUrl": "/artist/Mogwai/", "duration": 303, "album": "Hardcore Will Never Die, But You Will", "isClean": false, "albumUrl": "/artist/Mogwai/album/Hardcore_Will_Never_Die%2C_But_You_Will/", "shortUrl": "http://rd.io/x/Qis2Qto", "albumArtist": "Mogwai", "canStream": true, "embedUrl": "http://rd.io/e/Qis2Qto", "type": "t", "price": "0.99", "albumArtistKey": "r80466", "key": "t7609753", "icon": "http://media.rd.io/album/6/8/a/000000000009ba86/square-200.jpg", "canSample": true, "name": "White Noise", "isExplicit": false, "artist": "Mogwai", "url": "/artist/Mogwai/album/Hardcore_Will_Never_Die%2C_But_You_Will/track/White_Noise/", "albumKey": "a637574", "artistKey": "r80466", "canDownload": true, "length": 1, "canTether": true}}}'
    have = c.real_main args
    assert_equal want,have
  end

  def test_get_indent
    c = Call.new
    args = ['get', 'keys=t7609753','-i']
    want = "{\n  \"result\": {\n    \"t7609753\": {\n      \"artist\": \"Mogwai\",\n      \"name\": \"White Noise\",\n      \"price\": \"0.99\",\n      \"embedUrl\": \"http://rd.io/e/Qis2Qto\",\n      \"isClean\": false,\n      \"duration\": 303,\n      \"canDownload\": true,\n      \"albumArtist\": \"Mogwai\",\n      \"albumUrl\": \"/artist/Mogwai/album/Hardcore_Will_Never_Die%2C_But_You_Will/\",\n      \"artistUrl\": \"/artist/Mogwai/\",\n      \"baseIcon\": \"album/6/8/a/000000000009ba86/square-200.jpg\",\n      \"artistKey\": \"r80466\",\n      \"url\": \"/artist/Mogwai/album/Hardcore_Will_Never_Die%2C_But_You_Will/track/White_Noise/\",\n      \"icon\": \"http://media.rd.io/album/6/8/a/000000000009ba86/square-200.jpg\",\n      \"canDownloadAlbumOnly\": true,\n      \"canTether\": true,\n      \"canSample\": true,\n      \"type\": \"t\",\n      \"album\": \"Hardcore Will Never Die, But You Will\",\n      \"albumKey\": \"a637574\",\n      \"canStream\": true,\n      \"length\": 1,\n      \"key\": \"t7609753\",\n      \"albumArtistKey\": \"r80466\",\n      \"isExplicit\": false,\n      \"shortUrl\": \"http://rd.io/x/Qis2Qto\"\n    }\n  },\n  \"status\": \"ok\"\n}"
    have = c.real_main args
    assert_equal want,have
  end
  
end
