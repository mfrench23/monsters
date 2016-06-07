class CreateEquipmentModifierExclusions < ActiveRecord::Migration
  def change
    create_table :equipment_modifier_exclusions do |t|
      t.references :equipment_modifier, index: true
      t.references :excluded, index: true

      t.timestamps null: false
    end
    add_foreign_key :equipment_modifier_exclusions, :equipment_modifiers
    add_foreign_key :equipment_modifier_exclusions, :equipment_modifiers, column: :excluded_id, primary_key: "id"
  end
end
