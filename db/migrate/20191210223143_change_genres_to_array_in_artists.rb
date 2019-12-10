class ChangeGenresToArrayInArtists < ActiveRecord::Migration[5.2]
  def change
    change_column :artists, :genres, :string, array: true, default: [], using: "(string_to_array(genres, ','))"
  end
end
