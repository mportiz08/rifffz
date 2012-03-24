class TweakMp3Metadata < ActiveRecord::Migration
  def self.up
    add_column :songs, :bitrate, :integer
    change_column :albums, :year, :integer
  end

  def self.down
    change_column :albums, :year, :date
    remove_column :songs, :bitrate
  end
end
