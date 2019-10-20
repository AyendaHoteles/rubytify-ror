class AddDefaultValueToExplicitAttribute < ActiveRecord::Migration[5.2]
  def up
    change_column_default :songs, :explicit, false
  end

  def down
    change_column_default :songs, :explicit, nil
  end
end
