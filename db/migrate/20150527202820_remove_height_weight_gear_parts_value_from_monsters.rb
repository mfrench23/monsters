class RemoveHeightWeightGearPartsValueFromMonsters < ActiveRecord::Migration
  def change
    remove_column :monsters, :height, :string
    remove_column :monsters, :weight, :string
    remove_column :monsters, :gear, :text
    remove_column :monsters, :parts_value_cents, :integer
  end
end
