class CreateEquipmentTypes < ActiveRecord::Migration
  def change
    create_table :equipment_types do |t|
      t.string :name
      t.decimal :base_weight,                       precision: 10, scale: 4
      t.integer :base_cost_cents, limit: 4
      t.references :equipment_category, index: true
      t.text :notes

      t.timestamps null: false
    end
    add_foreign_key :equipment_types, :equipment_categories
  end
end
