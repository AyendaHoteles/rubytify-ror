class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.references :artist, foreign_key: true
      t.references :genre, foreign_key: true

    end
  end
end
