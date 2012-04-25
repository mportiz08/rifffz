module Rifffz
  class Stats
    def num_artists
      Artist.count
    end
    
    def num_albums
      Album.count
    end
    
    def num_songs
      Song.count
    end
    
    def num_genres
      Album.select(:genre).uniq.map(&:genre).count
    end
  end
end
