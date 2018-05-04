class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end



# Count all of the tracks on each album by a given artist.
  def better_tracks_query
    data = Artist.albums
      .select('COUNT(title)', albums)
      .join(:tracks)
      .group('albums.id')

    album_counts = {}

    data.each do |album|
      album_counts[album.title] = album.tracks_count
    end

    album_counts

  end
end
