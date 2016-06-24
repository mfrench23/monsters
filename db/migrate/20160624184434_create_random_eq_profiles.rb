class CreateRandomEqProfiles < ActiveRecord::Migration
  def change
    create_table :random_eq_profiles do |t|
      t.references :equipment_type, index: true
      t.references :equipment_category, index: true

      t.timestamps null: false
    end
    add_foreign_key :random_eq_profiles, :equipment_types
    add_foreign_key :random_eq_profiles, :equipment_categories
  end
end
