module Rifffz
  class Song < ActiveRecord::Base
    include Sluggable
    
    sluggable  :title
    belongs_to :album
    
    validates :title, presence: true
    validates :title, uniqueness: { scope: :album_id }
  end
end
