module Rifffz
  class Album < ActiveRecord::Base
    include Sluggable
    
    sluggable  :title
    has_many   :songs, dependent: :destroy
    belongs_to :artist
    
    validates :title, presence: true
    validates :title, uniqueness: { scope: :artist_id }
    
    def url
      "#{self.artist.url}/#{self.slug}"
    end
    
    def cover_url
      "#{self.url}/cover"
    end
  end
end
