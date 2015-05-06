class AddIndexToLocationsForName < ActiveRecord::Migration
  def up
    add_index :locations, :name, unique: true
  end

  def down
    remove_index :locations, :name
  end
end
