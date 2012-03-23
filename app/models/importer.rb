module Rifffz
  class Importer
    def initialize(path)
      @path = File.expand_path(path)
    end
    
    def import
      import_path(@path) if File.directory?(@path)
    end
    
    def self.supports?(file)
      ['.mp3'].include? File.extname(file)
    end
    
    private
    
    def import_path(path)
      if !File.directory?(path)
        import_song(path)
        return
      end
      
      Dir.foreach(path) do |entry|
        next if entry == '.' || entry == '..'
        import_path(File.expand_path(entry, path))
      end
    end
    
    def import_song(file)
      return unless Importer.supports?(file)
      puts "importing #{File.basename(file)}"
    end
  end
end
