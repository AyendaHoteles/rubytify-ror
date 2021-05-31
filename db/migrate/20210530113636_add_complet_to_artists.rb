class AddCompletToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :complet, :boolean, default: false
  end
end
