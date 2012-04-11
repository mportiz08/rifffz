require 'tempfile'

module Rifffz
  class GrowlNotification
    @@growlnotify_installed = system('which growlnotify > /dev/null')
    
    def initialize(title, msg, img)
      @title = title
      @msg   = msg
      @img   = img
    end
    
    def send
       return unless can_notify_growl?
       `growlnotify -n "rifffz" --image "#{@img}" -t "#{@title}" -m "#{@msg}"`
    end
    
    private
    
    def can_notify_growl?
      @@growlnotify_installed
    end
  end
end
