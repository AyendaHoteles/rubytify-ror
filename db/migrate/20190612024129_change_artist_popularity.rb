class ChangeArtistPopularity < ActiveRecord::Migration[5.2]
  def change
    remove_column :artists, :popularity
    add_column :artists, :popularity, :integer
  end
end
