class CreateRandomEqProfileLineItems < ActiveRecord::Migration
  def change
    create_table :random_eq_profile_line_items do |t|
      t.references :random_eq_profile
      t.references :equipment_modifier_supercategory
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :random_eq_profile_line_items, :random_eq_profile_id, :name => 'rand_eq_prof_line_idx'
    add_index :random_eq_profile_line_items, :equipment_modifier_supercategory_id, :name => 'rand_eq_prof_line_eq_sprcat_idx'

    add_foreign_key :random_eq_profile_line_items, :random_eq_profiles
    add_foreign_key :random_eq_profile_line_items, :equipment_modifier_supercategories
  end
end
