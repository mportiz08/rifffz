# encoding: utf-8

module Rifffz
  class Song < ActiveRecord::Base
    include Sluggable
    
    sluggable  :title
    belongs_to :album
    has_many   :playlist_items
    has_many   :playlists, through: :playlist_items
    
    validates :title, presence: true
    validates :title, uniqueness: { scope: :album_id }
    
    def notify_growl
       msg = "#{self.album.title}\n#{self.album.artist.name}"
       img = File.expand_path(File.join('app', 'public', 'images', 'albums', 'thumbnails', "#{self.album.id}.thumb"))
       GrowlNotification.new(self.title, msg, img).send
    end
    
    def url
      "#{self.album.url}/#{self.slug}"
    end
    
    def audio_url
      "#{self.url}/audio"
    end
    
    def as_json(options={})
      super({
        include: {
          album: {
            include: :artist,
            methods: :thumbnail
          }
        }
      })
    end
  end
end
