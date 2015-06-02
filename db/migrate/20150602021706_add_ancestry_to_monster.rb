class AddAncestryToMonster < ActiveRecord::Migration
  def change
    add_column :monsters, :ancestry, :string
    add_index :monsters, :ancestry
  end
end
