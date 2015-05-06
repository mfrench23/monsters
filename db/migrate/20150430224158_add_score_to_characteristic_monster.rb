class AddScoreToCharacteristicMonster < ActiveRecord::Migration
  def change
    add_column :characteristic_monsters, :score, :integer
  end
end
