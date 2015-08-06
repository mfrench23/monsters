class RemoveGearFromCreatures < ActiveRecord::Migration
  def change
    remove_column :creatures, :gear, :text
  end
end
