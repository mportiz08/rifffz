class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    create_table :albums do |t|
      t.string     :title
      t.string     :slug
      t.date       :year
      t.string     :cover
      t.references :artist
      t.timestamps
    end
    create_table :songs do |t|
      t.string     :title
      t.string     :slug
      t.string     :audio
      t.references :album
      t.timestamps
    end
  end

  def self.down
    drop_table :songs
    drop_table :albums
    drop_table :artists
  end
end
