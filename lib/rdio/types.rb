module Rdio

  # Dummy class so we can create booleans from strings
  class Boolean
    
  end

  # Dummy class so we can set the type variable in API methods to TODO
  class TODO

  end

  class Artist < ArtistData

    def initialize(api)
      super api
    end

    # Get all of the tracks by this artist.
    def get_tracks(appears_on=nil,start=nil,count=nil,extras=nil)
      return api.getTracksForArtist self,appears_on,start,count,extras
    end

    # Which tracks from the given artist are in the user's collection.
    def get_tracks_in_collection(user=nil,extras=nil)
      return api.getTracksForArtistInCollection self,user,extras
    end


    # Fetch one or more objects from Rdio of type Artist.
    def self.get(keys)
      return api.get keys,Artist
    end

    # Get all of the artist in a user's collection.
    def get_in_collection(user=nil,start=nil,count=nil,sort=nil,query=nil)
      return api.getArtistsInCollection user,start,count,sort,query
    end

    # Return the Artist that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.get_from_short_code(short_code)
      return api.getObjectFromShortCode short_code,Artist
    end

    # Return the Artist that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.get_from_url(url)
      return api.getObjectFromUrl url,Artist
    end

    # Return the site-wide most popular items for Artists
    def self.get_top_charts
      return api.getTopCharts Artist
    end


  end

  class Album < AlbumData

    def initialize(api)
      super api
    end

    # Fetch one or more objects from Rdio of type Album.
    def self.get(keys)
      return api.get keys,Album
    end

    # Return the albums by (or featuring) an artist.
    def self.get_for_artist(artist,featuring=nil,extras=nil,start=nil,count=nil)
      return api.getAlbumsForArtist artist,featuring,extras,start,count
    end

    # Get the albums in the user's collection by a particular artist.
    def self.get_for_artist_in_collection(artist,user=nil)
      return api.getAlbumsForArtistInCollection artist,user
    end

    # Get all of the albums in the user's collection.
    def self.get_in_collection(user=nil,start=nil,count=nil,
                          sort=nil,query=nil)
      return api.getAlbumsInCollection user,start,count,sort,query
    end

    # Return new albums released across a timeframe.
    def self.get_new_releases(time)
      return api.getNewReleases time
    end

    # Return the Albums that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.get_from_short_code(short_code)
      return api.getObjectFromShortCode short_code,Album
    end

    # Return the Album that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.get_from_url(url)
      return api.getObjectFromUrl url,Album
    end

    # Return the site-wide most popular items for Albums
    def self.get_top_charts
      return api.getTopCharts Album
    end

    # Which tracks on the given album are in the user's collection.
    def get_tracks_in_collection(user=nil,extras=nil)
      return api.getTracksForAlbumInCollection self,user,extras
    end

  end

  class Track < TrackData

    def initialize(api)
      super api
    end

    # Get all of the tracks in the user's collection.
    def self.get_in_collection(user=nil,start=nil,count=nil,sort=nil,query=nil)
      return api.getTracksInCollection user,start,count,sort,query
    end

    # Get all of the tracks by this artist.
    def self.get_for_artist(artist,appears_on=nil,start=nil,
                            count=nil,extras=nil)
      return api.getTracksForArtist artist,appears_on,start,count,extras
    end

    # Which tracks from the given artist are in the user's collection.
    def self.get_for_artist_in_collection(artist,user=nil,extras=nil)
      return api.getTracksForArtistInCollection artist,user,extras
    end

    # Fetch one or more objects from Rdio of type Track.
    def self.get(keys)
      return api.get keys,Track
    end

    # Return the Track that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.get_from_short_code(short_code)
      return api.getObjectFromShortCode short_code,Track
    end

    # Return the Track that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.get_from_url(url)
      return api.getObjectFromUrl url,Track
    end

    # Return the site-wide most popular items for Tracks
    def self.get_top_charts
      return api.getTopCharts Track
    end

    # Which tracks on the given album are in the user's collection.
    def self.get_for_album_in_collection(album,user=nil,extras=nil)
      return api.getTracksForAlbumInCollection album,user,extras
    end


  end

  class Playlist < PlaylistData

    def initialize(api)
      super api
    end

    # Remove an item from a playlist by its position in the playlist.
    def remove(index,count,tracks)
      return api.removeFromPlaylist self,index,count,tracks
    end


    # Add a track to a playlist.
    def add_to_playlist(tracks)
      return api.addToPlaylist self,tracks
    end

   # Create a new playlist in the current user's collection.  The new
   # playlist will be returned if the creation is successful,
   # otherwise null will be returned.
    def self.create(name,description,tracks,extras=nil)
      return api.createPlaylist name,description,tracks,extras
    end

    # Delete a playlist.
    def delete
      return api.deletePlaylist self
    end

    # Fetch one or more objects from Rdio of type Playlist.
    def self.get(keys)
      return api.get keys,Playlist
    end

    # Return the Playlist that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.get_from_short_code(short_code)
      return api.getObjectFromShortCode short_code,Playlist
    end

    # Return the Playlist that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.get_from_url(url)
      return api.getObjectFromUrl url,Playlist
    end

    # Return the site-wide most popular items for Playlists
    def self.get_top_charts
      return api.getTopCharts Playlist
    end

  end

  class User < UserData

    def initialize(api)
      super api
    end

    # Which tracks from the given artist are in the user's collection.
    def get_tracks_for_artist_in_collection(artist,extras=nil)
      return api.getTracksForArtistInCollection artist,self,extras
    end

    # Get all of the tracks in the user's collection.
    def get_tracks_in_collection(start=nil,count=nil,sort=nil,query=nil)
      return api.getTracksInCollection self,start,count,sort,query
    end

    # Add a friend to the current user.
    def self.add_friend(user)
      return api.addFriend user
    end

    # Remove a friend from the current user.
    def self.remove_friend(user)
      return api.removeFriend user
    end

    # Remove tracks or playlists from the current user's collection.
    def self.remove_from_collection(objs)
      return api.removeFromCollection objs
    end

    # Remove tracks from the current user's collection.
    def self.remove_tracks_from_collection(tracks)
      remove_from_collection tracks
    end

    # Remove playlistsfrom the current user's collection.
    def self.remove_playlists_from_collection(playlists)
      remove_from_collection playlists
    end

    # Add tracks or playlists to the current user's collection.
    def add_to_collection(objs)
      return api.addToCollection objs
    end

    # Get information about the currently logged in user.
    def self.current(extras=nil)
      return api.currentUser extras
    end

   # Find a user either by email address.
    def self.find_by_email(email)
      return api.findUserByEmail email
    end

   # Find a user either by email address.
    def self.find_by_vanity_name(name)
      return api.findUserByVanityName name
    end

    # Fetch one or more objects from Rdio of type User.
    def self.get(keys)
      return api.get keys,User
    end

    # Get the albums in the user's collection by a particular artist.
    def self.get_albums_for_artist_in_collection(artist)
      return api.getAlbumsForArtistInCollection artist,self
    end

    # Get all of the albums in the user's collection.
    def get_albums_in_collection(start=nil,count=nil,
                                 sort=nil,query=nil)
      return api.getAlbumsInCollection self,start,count,sort,query
    end

    # Get all of the artist in a user's collection.
    def get_albums_in_collection(start=nil,count=nil,sort=nil,query=nil)
      return api.getArtistsInCollection self,start,count,sort,query
    end

    # Find the most popular artists or albums for a user, their
    # friends or the whole site.
    def get_heavy_rotation(friends=nil,limit=nil)
      return api.getHeavyRotation self,nil,friends,limit
    end

    # Find the most popular artists for a user, their friends or the
    # whole site.
    def get_artists_heavy_rotation(friends=nil,limit=nil)
      return api.getHeavyRotation self,Artist,friends,limit
    end

    # Find the most popular albums for a user, their
    # friends or the whole site.
    def get_albums_heavy_rotation(friends=nil,limit=nil)
      return api.getHeavyRotation self,Album,friends,limit
    end

    # Return the User that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.get_from_short_code(short_code)
      return api.getObjectFromShortCode short_code,User
    end

    # Return the User that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.get_from_url(url)
      return api.getObjectFromUrl url,User
    end

    # Get the current user's playlists.
    def self.get_playlists(extras=nil)
      return api.getPlaylists extras
    end

    # Return the site-wide most popular items for Users
    def self.get_top_charts
      return api.getTopCharts User
    end

    # Which tracks on the given album are in the user's collection.
    def get_tracks_for_album_in_collection(album,extras=nil)
      return api.getTracksForAlbumInCollection album,self,extras
    end

    
  end

end
