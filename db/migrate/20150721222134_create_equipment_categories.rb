class CreateEquipmentCategories < ActiveRecord::Migration
  def change
    create_table :equipment_categories do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :equipment_categories, :name, unique: true
  end
end
