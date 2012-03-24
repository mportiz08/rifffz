require 'sinatra/base'
require 'active_record'
require_relative 'models'

module Rifffz
  class App < Sinatra::Base
    configure do
      ActiveRecord::Base.establish_connection(
        'adapter'   => 'sqlite3',
        'database'  => File.join(File.dirname(__FILE__), '..', 'db', 'library.db')
      )
    end
    
    get '/' do
      @albums = Album.all
      erb :"albums/index"
    end
    
    get '/:artist/:album' do
      @album = find_album(params)
      erb :"albums/show"
    end
    
    get '/:artist/:album/cover' do
      album = find_album(params)
      #send_file album.cover
      content_type 'application/octet-stream'
      album.cover
    end
    
    get '/:artist/:album/:song/audio' do
      song = find_song(params)
      send_file song.audio
    end
    
    private
    
    def find_album(params)
      Artist.find_by_slug(params[:artist]).albums.find_by_slug(params[:album])
    end
    
    def find_song(params)
      find_album(params).songs.find_by_slug(params[:song])
    end
  end
end
