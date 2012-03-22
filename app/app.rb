require 'sinatra/base'

module Rifffz
  class App < Sinatra::Base
    get '/' do
      'hello, world'
    end
  end
end
