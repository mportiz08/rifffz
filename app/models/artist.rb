module Rifffz
  class Artist < ActiveRecord::Base
    include Sluggable
    
    sluggable :name
    has_many  :albums
    
    validates :name, presence: true
    validates :name, uniqueness: true
  end
end
