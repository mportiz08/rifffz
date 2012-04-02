# encoding: utf-8

require 'logger'
require 'taglib2'

module Rifffz
  class Importer
    def initialize(path)
      @logger = Logger.new(File.join('log', 'importer.log'))
      @path   = File.expand_path(path)
    end
    
    def import
      @logger.info 'Importing started.'
      import_path(@path) if File.directory?(@path)
      @logger.info 'Importing finished.'
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
      if Song.find_by_audio(file) || !Importer.supports?(file)
        return
      end
      
      @logger.info "Importing #{file}..."
      
      song_info = TagLib2::File.new(file)
      song = Song.create(
        audio:   file,
        title:   song_info.title,
        track:   song_info.track,
        bitrate: song_info.bitrate
      )
      
      artist = Artist.find_by_name(song_info.artist)
      artist = Artist.create(name: song_info.artist) if artist.nil?
      
      album = artist.albums.where(title: song_info.album).first
      if album.nil?
        album = Album.create(
          title: song_info.album,
          year:  song_info.year
        )
        album.genre = song_info.genre
        album.cover = song_info.image(0).data if song_info.imageCount > 0
        album.artist = artist
        album.save 
      end
      
      song.album = album
      song.save
    end
  end
end
