class AddGenresToArtist < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :genres, :string, array: true, default: [].to_yaml
  end
end
