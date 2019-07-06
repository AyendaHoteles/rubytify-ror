# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :url
      t.integer :width
      t.integer :height
      t.references :owner, polymorphic: true, index: true

      t.timestamps
    end
  end
end
