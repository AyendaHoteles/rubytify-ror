class DestroyGenresField < ActiveRecord::Migration[5.2]
  def change
    remove_column :artists, :genres
  end
end
