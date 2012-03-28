module Rifffz
  class Artist < ActiveRecord::Base
    include Sluggable
    
    sluggable :name
    has_many  :albums, dependent: :destroy, order: 'year'
    
    validates :name, presence: true
    validates :name, uniqueness: true
    
    def url
      "/#{self.slug}"
    end
  end
end
