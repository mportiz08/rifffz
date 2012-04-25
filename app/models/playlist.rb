# encoding: utf-8

module Rifffz
  class Playlist < ActiveRecord::Base
    include Sluggable
    
    sluggable :title
    has_many  :playlist_items
    has_many  :songs, through: :playlist_items
    
    validates :title, presence: true
    validates :title, uniqueness: true
    
    def self.latest_update
      self.select('updated_at').order('updated_at').last.updated_at
    end
    
    def url
      "/playlists/#{self.slug}"
    end
    
    def cover_url
      "/images/default_cover.png"
    end
    
    def thumbnail
      "/images/default_cover_thumbnail.png"
    end
  end
end
