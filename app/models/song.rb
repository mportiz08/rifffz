module Rifffz
  class Song < ActiveRecord::Base
    include Sluggable
    
    sluggable  :title
    belongs_to :album
    
    validates :title, presence: true
    validates :title, uniqueness: { scope: :album_id }
    
    def notify_growl
       msg = "#{self.album.title}\n#{self.album.artist.name}"
       notification = GrowlNotification.new(self.title, msg)
       notification.attach_image(self.album.cover)
       notification.send
    end
  end
end
