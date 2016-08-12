class CreateRpmRitualModifiers < ActiveRecord::Migration
  def change
    create_table :rpm_ritual_modifiers do |t|
      t.references :rpm_ritual, index: true
      t.references :rpm_modifier_level, index: true
      t.text :notes
      t.integer :enhancement_percentage

      t.timestamps null: false
    end
    add_foreign_key :rpm_ritual_modifiers, :rpm_rituals
    add_foreign_key :rpm_ritual_modifiers, :rpm_modifier_levels
  end
end
