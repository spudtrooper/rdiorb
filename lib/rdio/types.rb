# -*- coding: utf-8 -*-

module Rdio

  # ----------------------------------------------------------------------
  # Represents an artist on Rdio, either an individual performer or a
  # group
  # ----------------------------------------------------------------------
  class Artist < ArtistData

    def initialize(api)
      super api
    end

    attr_accessor :albums
    attr_accessor :play_count
    attr_accessor :secondary_id
    attr_accessor :count
    attr_accessor :has_offline
    attr_accessor :sortable_name
    attr_accessor :id

    attr_accessor :user_name
    attr_accessor :frozen_track_list
    attr_accessor :artist_url
    attr_accessor :user_key
    attr_accessor :artist_name

    attr_accessor :tracks

    attr_accessor :album_keys

    # Returns an array of Album for the query and other params
    def self.search(query,never_or=nil,extras=nil,start=nil,count=nil)
      extras = Rdio::add_to_array extras,'artists'
      Search.search query,Artist,never_or,extras,start,count
    end

    # Get all of the tracks by this artist.
    def tracks(appears_on=nil,start=nil,count=nil,extras=nil)
      api.getTracksForArtist self,appears_on,start,count,extras
    end
    
    # Get all the albums by this artist
    def albums(featuring=nil,extras=nil,start=nil,count=nil)
      api.getAlbumsForArtist self,featuring,extras,start,count
    end

    # Which tracks from the given artist are in the user's collection.
    def tracks_in_collection(user=nil,extras=nil)
      api.getTracksForArtistInCollection self,user,extras
    end

    # Fetch one or more objects from Rdio of type Artist.
    def self.all(keys,extras=nil)
      Rdio::api.get keys,Artist,extras
    end

    # Fetch one object from Rdio of type Artist.
    def self.get(key,extras=nil)
      arr = all [key],extras
      (arr and not arr.empty?) ? arr[0] : nil
    end

    # Get all of the artist in a user's collection.
    def in_collection(user=nil,start=nil,count=nil,sort=nil,query=nil)
      api.getArtistsInCollection user,start,count,sort,query
    end

    # Return the Artist that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.from_short_code(short_code)
      Rdio::api.getObjectFromShortCode short_code,Artist
    end

    # Return the Artist that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.from_url(url)
      Rdio::api.getObjectFromUrl url,Artist
    end

    # Return the site-wide most popular items for Artists
    def self.top_charts
      Rdio::api.getTopCharts Artist
    end

  end


  # ----------------------------------------------------------------------
  # Represents a recording on Rdio, usually an album but often a
  # single, EP or compilation
  # ----------------------------------------------------------------------
  class Album < AlbumData

    def initialize(api)
      super api
    end

    # big icon
    attr_accessor :big_icon

    # the track ids
    attr_accessor :track_ids

    # the secondary id
    attr_accessor :secondary_id

    # the tracks
    attr_accessor :tracks

    # indicates if the album is a compilation
    attr_accessor :is_compilation

    # indicates if the album is a compilation
    def compilation?
      is_compilation
    end

    # is the album explicit?
    def explicit?
      is_explicit
    end

    # is the album clean
    def clean?
      is_clean
    end
    
    # Returns the Artist
    def artist
      Artist.get artist_key
    end

    # Returns the String artist name
    def artist_name
      @artist
    end

    # Return an array of Track
    def tracks(extras=nil)
      Track.all @tracks,extras
    end

    # Returns an array of Album for the query and other params
    def self.search(query,never_or=nil,extras=nil,start=nil,count=nil)
      extras = Rdio::add_to_array extras,'albums'
      Search.search query,Album,never_or,extras,start,count
    end

    # Fetch one or more objects from Rdio of type Album.
    def self.all(keys,extras=nil)
      Rdio::api.get keys,Album,extras
    end

    # Fetch one object from Rdio of type Album.
    def self.get(key,extras=nil)
      arr = all [key],extras
      (arr and not arr.empty?) ? arr[0] : nil
    end

    # Return the albums by (or featuring) an artist.
    def self.for_artist(artist,featuring=nil,extras=nil,start=nil,count=nil)
      Rdio::api.getAlbumsForArtist artist,featuring,extras,start,count
    end

    # Get the albums in the user's collection by a particular artist.
    def self.for_artist_in_collection(artist,user=nil,extras=nil)
      Rdio::api.getAlbumsForArtistInCollection artist,user,extras
    end

    # Get all of the albums in the user's collection.
    def self.in_collection(user=nil,start=nil,count=nil,
                          sort=nil,query=nil,extras=nil)
      Rdio::api.getAlbumsInCollection user,start,count,sort,query,extras
    end

    # Return new albums released across a timeframe.
    def self.new_releases(time)
      Rdio::api.getNewReleases time
    end

    # Return the Albums that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.from_short_code(short_code)
      Rdio::api.getObjectFromShortCode short_code,Album
    end

    # Return the Album that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.from_url(url)
      Rdio::api.getObjectFromUrl url,Album
    end

    # Return the site-wide most popular items for Albums
    def self.top_charts
      Rdio::api.getTopCharts Album
    end

    # Which tracks on the given album are in the user's collection.
    def tracks_in_collection(user=nil,extras=nil)
      api.getTracksForAlbumInCollection self,user,extras
    end

  end

  # ----------------------------------------------------------------------
  # Represents a song on Rdio
  # ----------------------------------------------------------------------
  class Track < TrackData

    def initialize(api)
      super api
    end

    # the track number
    attr_accessor :track_num

    # the secondary id
    attr_accessor :secondary_id

    # indicates if the track is on a compilation
    attr_accessor :is_on_compilation

    # big icon
    attr_accessor :big_icon

    # indicates if the track is on a compilation
    def on_compilation?
      is_on_compilation
    end

    # Returns the Album
    def album(extras=nil)
      Album.get @album_key,extras
    end

    # Returns the Artist
    def artist(extras=nil)
      Artist.get @artist_key,extras
    end

    # Returns the album Artist
    def album_artist(extras=nil)
      Artist.get @album_artist_key,extras
    end

    # Returns the String album name
    def album_name
      @album
    end

    # Returns the string artist name
    def artist_name
      @artist
    end

    # Returns the string album artist name
    def album_artist_name
      @album_artist
    end

    # Returns an array of Track for the query and other params
    def self.search(query,never_or=nil,extras=nil,start=nil,count=nil)
      extras = Rdio::add_to_array extras,'tracks'
      Search.search query,Track,never_or,extras,start,count
    end

    # Get all of the tracks in the user's collection.
    def self.in_collection(user=nil,start=nil,count=nil,
                           sort=nil,query=nil,extras=nil)
      Rdio::api.getTracksInCollection user,start,count,sort,query,extras
    end

    # Get all of the tracks by this artist.
    def self.for_artist(artist,appears_on=nil,start=nil,
                            count=nil,extras=nil)
      Rdio::api.getTracksForArtist artist,appears_on,start,count,extras
    end

    # Which tracks from the given artist are in the user's collection.
    def self.for_artist_in_collection(artist,user=nil,extras=nil)
      Rdio::api.getTracksForArtistInCollection artist,user,extras
    end

    # Fetch one or more objects from Rdio of type Track.
    def self.all(keys,extras=nil)
      Rdio::api.get keys,Track,extras
    end

    # Fetch one object from Rdio of type Track.
    def self.get(key,extras=nil)
      arr = all [key],extras
      return (arr and not arr.empty?) ? arr[0] : nil
    end

    # Return the Track that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.from_short_code(short_code)
      Rdio::api.getObjectFromShortCode short_code,Track
    end

    # Return the Track that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.from_url(url)
      Rdio::api.getObjectFromUrl url,Track
    end

    # Return the site-wide most popular items for Tracks
    def self.top_charts
      Rdio::api.getTopCharts Track
    end

    # Which tracks on the given album are in the user's collection.
    def self.for_album_in_collection(album,user=nil,extras=nil)
      Rdio::api.getTracksForAlbumInCollection album,user,extras
    end

  end

  # ----------------------------------------------------------------------
  # Represents a playlist on Rdio
  # ----------------------------------------------------------------------
  class Playlist < PlaylistData

    def initialize(api)
      super api
    end

    # big icon
    attr_accessor :big_icon
    
    # track keys
    attr_accessor :track_keys

    # Remove an item from a playlist by its position in the playlist.
    def remove(index,count,tracks)
      api.removeFromPlaylist self,index,count,tracks
    end

    # Returns an array of Playlist for the query and other params
    def self.search(query,never_or=nil,extras=nil,start=nil,count=nil)
      extras = Rdio::add_to_array extras,'playlists'
      Search.search query,Playlist,never_or,extras,start,count
    end

    # Add a track to a playlist.
    def add_to_playlist(tracks)
      api.addToPlaylist self,tracks
    end

   # Create a new playlist in the current user's collection.  The new
   # playlist will be returned if the creation is successful,
   # otherwise null will be returned.
    def self.create(name,description,tracks,extras=nil)
      Rdio::api.createPlaylist name,description,tracks,extras
    end

    # Delete a playlist.
    def delete
      api.deletePlaylist self
    end

    # Fetch one or more objects from Rdio of type Playlist.
    def self.all(keys,extras=nil)
      Rdio::api.get keys,Playlist,extras
    end

    # Fetch one object from Rdio of type Playlist.
    def self.get(key,extras=nil)
      arr = all [key],extras
      return (arr and not arr.empty?) ? arr[0] : nil
    end

    # Return the Playlist that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.from_short_code(short_code)
      Rdio::api.getObjectFromShortCode short_code,Playlist
    end

    # Return the Playlist that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.from_url(url)
      Rdio::api.getObjectFromUrl url,Playlist
    end

    # Return the site-wide most popular items for Playlists
    def self.top_charts
      Rdio::api.getTopCharts Playlist
    end

    # Start or stop collaborating on this playlist.
    def collaborating=(collaborating)
      Rdio::api.setPlaylistCollaborating self,collaborating
    end

    # Start or stop collaborating on this playlist.
    def collaboration_mode=(mode)
      Rdio::api.setPlaylistCollaborationMode self,mode
    end

    # Saves the given order of tracks in a given playlist. The new
    # order must have the same tracks as the previous order (this
    # method may not be used to add/remove tracks).
    def order=(tracks)
      Rdio::api.setPlaylistOrder self,tracks
    end

    # Sets the name and description for a playlist.
    def set_fields(name,description)
      Rdio::api.setPlaylistFields self,name,description
    end

  end

  # ----------------------------------------------------------------------
  # Represents an Rdio user
  # ----------------------------------------------------------------------
  class User < UserData

    def initialize(api)
      super api
    end

    # isTrial
    attr_accessor :is_trial

    # isSubscriber
    attr_accessor :is_subscriber
    
    # isUnlimited
    attr_accessor :is_unlimited

    # isTrial
    def trial?
      is_trial
    end

    # isSubscriber
    def subscriber?
      is_subscriber
    end
    
    # isUnlimited
    def unlimited?
      is_unlimited
    end

    # Get the activity events for a user, a user's friends, or
    # everyone on Rdio.
    def activity_stream(scope='user',last_id=nil)
      api.getActivityStream self,scope,last_id
    end

    # Returns an array of User for the query and other params
    def self.search(query,never_or=nil,extras=nil,start=nil,count=nil)
      extras = Rdio::add_to_array extras,'users'
      Search.search query,User,never_or,extras,start,count
    end

    # Get information about the currently logged in user.
    def self.current(extras=nil)
      Rdio::api.currentUser extras
    end

   # Find a user either by email address.
    def self.find_by_email(email)
      Rdio::api.findUserByEmail email
    end

   # Find a user either by email address.
    def self.find_by_vanity_name(name)
      Rdio::api.findUserByVanityName name
    end

    # Finds the user by email or vanity name
    def self.find(s)
      s =~ /@/ ? find_by_email(s) : find_by_vanity_name(s)
    end

    # Fetch one or more objects from Rdio of type User.
    def self.all(keys,extras=nil)
      Rdio::api.get keys,User,extras
    end

    # Fetch one object from Rdio of type User.
    def self.get(key,extras=nil)
      arr = all [key],extras
      return (arr and not arr.empty?) ? arr[0] : nil
    end

    # Get all of the albums in the user's collection.
    def albums_in_collection(start=nil,count=nil,sort=nil,query=nil)
      api.getAlbumsInCollection self,start,count,sort,query
    end

    # Get the albums in the user's collection by a particular artist.
    def albums_for_artist_in_collection(artist)
      api.getAlbumsForArtistInCollection artist,self
    end

    # Get all of the artist in a user's collection.
    def artists_in_collection(start=nil,count=nil,sort=nil,
                              query=nil,extras=nil)
      api.getArtistsInCollection self,start,count,sort,query,extras
    end

    # Which tracks from the given artist are in the user's collection.
    def tracks_for_artist_in_collection(artist,extras=nil)
      api.getTracksForArtistInCollection artist,self,extras
    end

    # Get all of the tracks in the user's collection.
    def tracks_in_collection(start=nil,count=nil,sort=nil,query=nil,extras=nil)
      api.getTracksInCollection self,start,count,sort,query,extras
    end

    # Which tracks on the given album are in the user's collection.
    def tracks_for_album_in_collection(album,extras=nil)
      api.getTracksForAlbumInCollection album,self,extras
    end

    # Add a friend to the current user.
    def self.add_friend(user)
      Rdio::api.addFriend user
    end

    # Remove a friend from the current user.
    def self.remove_friend(user)
      Rdio::api.removeFriend user
    end

    # Remove tracks or playlists from the current user's collection.
    def self.remove_from_collection(objs)
      Rdio::api.removeFromCollection objs
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
    def self.add_to_collection(objs)
      Rdio::api.addToCollection objs
    end

    # Add tracks to the current user's collection.
    def self.add_tracks_to_collection(tracks)
      add_to_collection tracks
    end

    # Add playlists to the current user's collection.
    def self.add_playlists_to_collection(playlists)
      add_to_collection playlists
    end

    # Find the most popular artists or albums for a user, their
    # friends or the whole site.
    def heavy_rotation(friends=nil,limit=nil,extras=nil)
      api.getHeavyRotation self,nil,friends,limit,extras
    end

    # Find the most popular artists for a user, their friends or the
    # whole site.
    def artists_heavy_rotation(friends=nil,limit=nil)
      api.getHeavyRotation self,Artist,friends,limit
    end

    # Find the most popular albums for a user, their
    # friends or the whole site.
    def albums_heavy_rotation(friends=nil,limit=nil)
      api.getHeavyRotation self,Album,friends,limit
    end

    # Return the User that the supplied Rdio short-code is a
    # representation of, or null if the short-code is invalid.
    def self.from_short_code(short_code)
      Rdio::api.getObjectFromShortCode short_code,User
    end

    # Return the User that the supplied Rdio url is a representation
    # of, or null if the url doesn't represent an object.
    def self.from_url(url)
      Rdio::api.getObjectFromUrl url,User
    end

    # Get the current user's playlists.
    def self.playlists(extras=nil)
      Rdio::api.getPlaylists extras
    end

    # Return the site-wide most popular items for Users
    def self.top_charts
      Rdio::api.getTopCharts User
    end


  end

  # ----------------------------------------------------------------------  
  # An activity stream.
  # ----------------------------------------------------------------------
  class ActivityStream < ApiObj

    # used to walk through activity
    attr_accessor :last_id

    # the User object for the user that was passed in
    attr_accessor :user

    # the updates
    attr_accessor :updates

    def initialize(api)
      super api
    end

    class Update < ApiObj

      # One of the following
      #   0 — track added to collection
      #   1 — track added to playlist
      #   3 — friend added
      #   5 — user joined
      #   6 — comment added to track
      #   7 — comment added to album
      #   8 — comment added to artist
      #   9 — comment added to playlist
      #  10 — track added via match collection
      #  11 — user subscribed to Rdio
      #  12 — track synced to mobile
      attr_accessor :update_type

      # string date
      attr_accessor :date

      # User owner
      attr_accessor :owner

      # Albums
      attr_accessor :albums

      # People
      attr_accessor :people
      
      def initialize(api)
        super api
      end

    end

  end

  # Wrapper for search
  class Search
    
    # Search for 'query' and other parameters
    def self.counts(query,types=nil,never_or=nil,extras=nil,start=nil,count=nil)
      Rdio::api.counts query,types,never_or,extras,start,count
    end

    # Searches for objects with type 'type' and 'query' and other
    # parameters
    def self.search(query,types=nil,never_or=nil,extras=nil,start=nil,count=nil)
      Rdio::api.search query,types,never_or,extras,start,count
    end
    
  end

  # Dummy class so we can create booleans from strings
  class Boolean
    
  end

  # Dummy class so we can set the type variable in API methods to TODO
  class TODO

  end
  
  # ----------------------------------------------------------------------
  # Set up the mapping of names of attributes to the classes with
  # which we will construct the JSON.
  #
  # TODO: May want to put these in individual classes?
  # ----------------------------------------------------------------------
  Rdio::symbols_to_types = {
    :user => User,
    :owner => User,
    :friends => User,
    :everyone => User,
    :people => User,
    :users => User,
    :artists => Artist,
    :albums => Album,
    :tracks => Track,
    :playlists => Playlist,
    :updates => ActivityStream::Update,
  }

end
