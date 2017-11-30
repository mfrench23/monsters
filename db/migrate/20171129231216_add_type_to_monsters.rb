class AddTypeToMonsters < ActiveRecord::Migration
  def change
    add_column :monsters, :type, :string
    add_column :monsters, :number_description, :text
    add_column :monsters, :height, :string
    add_column :monsters, :weight, :string
    add_column :monsters, :parts_value_cents, :integer, limit: 4
  end
end
