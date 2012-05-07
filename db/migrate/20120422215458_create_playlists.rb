class CreatePlaylists < ActiveRecord::Migration
  def self.up
    create_table :playlists do |t|
      t.string     :title
      t.string     :slug
      t.timestamps
    end
    create_table :playlist_items do |t|
      t.references :playlist
      t.references :song
    end
  end

  def self.down
    drop_table :playlist_items
    drop_table :playlists
  end
end
