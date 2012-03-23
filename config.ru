require File.join(File.dirname(__FILE__), 'app', 'app')
require 'sprockets'

assets = Sprockets::Environment.new
assets.append_path 'app/assets'

map '/assets' do 
  run assets
end

map '/' do
  run Rifffz::App
end
