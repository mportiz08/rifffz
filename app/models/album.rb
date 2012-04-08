# encoding: utf-8

require 'rmagick'

module Rifffz
  class Album < ActiveRecord::Base
    include Sluggable
    
    before_save :make_thumbnail
    
    sluggable  :title
    has_many   :songs, dependent: :destroy, order: 'track'
    belongs_to :artist
    
    validates :title, presence: true
    validates :title, uniqueness: { scope: :artist_id }
    
    def self.library
      self.all.sort_by { |a| [a.artist.name.gsub(/^(a\s|an\s|the\s)/i, ''), a.year] }
    end
    
    def self.latest_update
      self.select('updated_at').order('updated_at').last.updated_at
    end
    
    def url
      "#{self.artist.url}/#{self.slug}"
    end
    
    def cover_url
      "#{self.url}/cover"
    end
    
    def make_thumbnail
      return if self.cover.nil?
      
      path = File.expand_path(File.join('app', 'public', 'images', 'albums', 'thumbnails', "#{self.id}.thumb"))
      File.open(path, 'w') { |f| f.write(self.cover.force_encoding('ASCII-8BIT')) }
      Magick::Image.read(path).first.scale(210, 210).write(path)
    end
    
    def thumbnail
      self.cover.nil? ? "/images/default_cover_thumbnail.png" : "/images/albums/thumbnails/#{self.id}.thumb"
    end
  end
end
