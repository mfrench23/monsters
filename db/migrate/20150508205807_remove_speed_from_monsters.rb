class RemoveSpeedFromMonsters < ActiveRecord::Migration
  def change
    remove_column :monsters, :speed, :decimal
  end
end
