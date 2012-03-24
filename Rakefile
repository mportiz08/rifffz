require File.join(File.dirname(__FILE__), 'app', 'app')
require 'rake'
require 'sinatra/activerecord/rake'

desc "Open an irb session preloaded with this app."
task :console do
  sh "irb -r ./app/app"
end

namespace :db do
  desc "Show the database schema."
  task :schema do
    [Rifffz::Artist, Rifffz::Album, Rifffz::Song].each do |model|
      puts model.name
      puts model.columns.map { |c| {c.name => c.sql_type} }
      puts ''
    end
  end
  
  desc "Clear the music library database."
  task :clear do
    Rifffz::Song.destroy_all
    Rifffz::Album.destroy_all
    Rifffz::Artist.destroy_all
  end
end
