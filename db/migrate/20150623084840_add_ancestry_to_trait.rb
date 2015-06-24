class AddAncestryToTrait < ActiveRecord::Migration
  def change
    add_column :traits, :ancestry, :string
    add_index :traits, :ancestry
  end
end
