module Rifffz
  class Album < ActiveRecord::Base
    include Sluggable
    
    sluggable  :title
    has_many   :songs, dependent: :destroy, order: 'track'
    belongs_to :artist
    
    validates :title, presence: true
    validates :title, uniqueness: { scope: :artist_id }
    
    def self.library
      self.all.sort_by { |a| [a.artist.name.gsub(/^(a\s|an\s|the\s)/i, ''), a.year] }
    end
    
    def url
      "#{self.artist.url}/#{self.slug}"
    end
    
    def cover_url
      "#{self.url}/cover"
    end
  end
end
