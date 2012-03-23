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
    
    get '/:artist/:album/cover' do
      album = find_album(params[:artist], params[:album])
      send_file album.cover
    end
    
    private
    
    def find_album(artist_slug, album_slug)
      Artist.find_by_slug(artist_slug).albums.find_by_slug(album_slug)
    end
  end
end
