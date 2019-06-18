class ChangeColumntToSongs < ActiveRecord::Migration[5.2]
  def change
    change_column :songs, :explicit, :boolean, using: 'explicit::boolean'
  end
end
