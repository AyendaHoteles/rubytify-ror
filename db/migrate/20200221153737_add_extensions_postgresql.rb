# frozen_string_literal: true

class AddExtensionsPostgresql < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
    enable_extension 'plpgsql'
  end
end
