require 'tempfile'

module Rifffz
  class GrowlNotification
    @@growlnotify_installed = system('which growlnotify > /dev/null')
    
    def initialize(title, msg)
      @title = title
      @msg   = msg
    end
    
    def attach_image(img_data)
      @img = Tempfile.new(@title)
      @img.write(img_data)
    end
    
    def send
       return unless can_notify_growl?
       `growlnotify -n "rifffz" --image "#{@img.path}" -t "#{@title}" -m "#{@msg}"`
    end
    
    private
    
    def can_notify_growl?
      @@growlnotify_installed
    end
  end
end
