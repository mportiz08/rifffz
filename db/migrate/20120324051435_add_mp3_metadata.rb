class AddMp3Metadata < ActiveRecord::Migration
  def self.up
    add_column :songs, :track, :integer
    add_column :albums, :genre, :string
    change_column :albums, :cover, :binary
  end

  def self.down
    change_column :albums, :cover, :string
    remove_column :albums, :genre
    remove_column :songs, :track
  end
end
