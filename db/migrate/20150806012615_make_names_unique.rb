class MakeNamesUnique < ActiveRecord::Migration
  def change
    remove_index :monsters, :name
    remove_index :master_skills, :name
    remove_index :equipment_categories, :name

    add_index :monsters, :name, :unique => true
    add_index :equipment_types, :name, :unique => true
    add_index :master_skills, :name, :unique => true
    add_index :equipment_categories, :name, :unique => true
  end
end
