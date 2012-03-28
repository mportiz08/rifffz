require 'tempfile'

module Rifffz
  class GrowlNotification
    def initialize(title, msg)
      @title = title
      @msg   = msg
    end
    
    def attach_image(img_data)
      @img = Tempfile.new(@title)
      @img.write(img_data)
    end
    
    def send
       return unless growlnotify_installed?
       
       begin
         `growlnotify -n "rifffz" --image "#{@img.path}" -t "#{@title}" -m "#{@msg}" --wait`
       ensure
         @img.unlink
         @img.close!
       end
    end
    
    private
    
    def growlnotify_installed?
      `which growlnotify`
      $?.success?
    end
  end
end
