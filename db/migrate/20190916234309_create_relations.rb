class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.belongs_to :artist, foreign_key: true
      t.belongs_to :gender, foreign_key: true

      t.timestamps
    end
  end
end
