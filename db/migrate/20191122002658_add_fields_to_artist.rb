class AddFieldsToArtist < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :name, :string
    add_column :artists, :image, :string
    add_column :artists, :genres, :text, array:true, default: []
    add_column :artists, :popularity, :string
    add_column :artists, :spotify_url, :string
    add_column :artists, :spotify_id, :string
  end
end
