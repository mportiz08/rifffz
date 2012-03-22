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
      'hello, world'
    end
  end
end
