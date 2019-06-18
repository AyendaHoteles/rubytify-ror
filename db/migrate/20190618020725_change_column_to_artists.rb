class ChangeColumnToArtists < ActiveRecord::Migration[5.2]
  def change
    change_column :artists, :popularity, :integer, using: 'popularity::integer'
  end
end
