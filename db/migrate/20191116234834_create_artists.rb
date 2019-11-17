class CreateArtists < ActiveRecord::Migration[6.0]
  def up
    create_table :artists do |t|
      t.string :spotify_id
      t.string :name
      t.string :image
      t.string :genres
      t.integer :popularity
      t.string :spotify_url

      t.timestamps
    end
    #Change genres default string tyte to Array<string>
    change_column :artists, :genres, :string, array: true, default: nil, using: "(string_to_array(genres, ','))"
    
    #column default
    #change_column_default(:artists, :genres, [])
  end
  
 
  def down
    drop_table :artists
  end
end
