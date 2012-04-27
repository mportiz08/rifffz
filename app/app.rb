# encoding: utf-8

require 'sinatra/base'
require 'sinatra/flash'
require 'active_record'
require 'rack/cache'
require_relative 'models'

Encoding.default_external = Encoding::UTF_8

module Rifffz
  class App < Sinatra::Base
    enable :sessions
    
    use Rack::Cache
    
    register Sinatra::Flash
    
    configure do
      ActiveRecord::Base.establish_connection(
        'adapter'   => 'sqlite3',
        'database'  => File.join(File.dirname(__FILE__), '..', 'db', 'library.db'),
        'encoding'  => 'utf8',
        'charset'   => 'utf8'
      )
    end
    
    get '/' do
      @dirs = autocomplete_dirs
      #@albums = Album.library
      @song_lists = Album.library
      #last_modified Album.latest_update
      erb :"shared/song_lists"
    end
    
    get '/stats/?' do
      @stats = Stats.new
      last_modified Album.latest_update
      erb :"stats/index"
    end
    
    get '/playlists/?' do
      @dirs = autocomplete_dirs
      @song_lists = Playlist.all
      erb :"shared/song_lists"
    end
    
    get '/:artist/?' do
      @dirs = autocomplete_dirs
      @song_lists = find_artist(params).albums
      last_modified @song_lists.select('updated_at').order('updated_at').last.updated_at
      erb :"shared/song_lists"
    end
    
    get '/:artist/:album/?' do
      @album = find_album(params)
      last_modified @album.updated_at
      erb :"albums/show"
    end
    
    get '/:artist/:album/cover' do
      album = find_album(params)
      if album.cover.nil?
        send_file File.expand_path(File.join('app', 'public', 'images', 'default_cover.png'))
      else
        last_modified album.updated_at
        content_type 'application/octet-stream'
        album.cover
      end
    end
    
    get '/:artist/:album/:song/audio' do
      song = find_song(params)
      send_file song.audio
    end
    
    post '/songs/play' do
      song = find_song(params)
      song.notify_growl
    end
    
    post '/albums/create' do
      Importer.new(params['album-path']).import
      flash[:notice] = "All of the albums found in <strong>#{params['album-path']}</strong> were successfully imported."
      redirect '/'
    end
    
    private
    
    def find_artist(params)
      Artist.find_by_slug(params[:artist])
    end
    
    def find_album(params)
      find_artist(params).albums.find_by_slug(params[:album])
    end
    
    def find_song(params)
      find_album(params).songs.find_by_slug(params[:song])
    end
    
    def autocomplete_dirs
      Dir.glob('library/*').select { |f| File.directory?(f) } +
      Dir.glob('library/*/**').select { |f| File.directory?(f) }
    end
  end
end
