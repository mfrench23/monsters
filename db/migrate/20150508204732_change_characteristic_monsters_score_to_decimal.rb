class ChangeCharacteristicMonstersScoreToDecimal < ActiveRecord::Migration
  def up
    change_column :characteristic_monsters, :score, :decimal, :precision => 6, :scale => 2
  end

  def down
    change_column :characteristic_monsters, :score, :integer
  end
end
