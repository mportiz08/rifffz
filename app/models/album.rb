module Rifffz
  class Album < ActiveRecord::Base
    include Sluggable
    
    sluggable  :title
    has_many   :songs
    belongs_to :artist
    
    validates :title, presence: true
    validates :title, uniqueness: { scope: [:artist_id, :year] }
  end
end
