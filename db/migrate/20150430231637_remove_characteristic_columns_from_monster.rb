class RemoveCharacteristicColumnsFromMonster < ActiveRecord::Migration
  def change
    remove_column :monsters, :strength, :integer
    remove_column :monsters, :dexterity, :integer
    remove_column :monsters, :intelligence, :integer
    remove_column :monsters, :health, :integer
    remove_column :monsters, :hitPoints, :integer
    remove_column :monsters, :will, :integer
    remove_column :monsters, :perception, :integer
    remove_column :monsters, :fatigue, :integer
    remove_column :monsters, :sizeModifier, :integer
  end
end
