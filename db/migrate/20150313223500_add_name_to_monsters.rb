class AddNameToMonsters < ActiveRecord::Migration
  def change
    add_column :monsters, :name, :string
  end
end
