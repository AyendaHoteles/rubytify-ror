class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :name

      t.timestamps
    end

    create_table :artists_genres, id: false do |t|
      t.belongs_to :artists
      t.belongs_to :genres
    end
  end
end
