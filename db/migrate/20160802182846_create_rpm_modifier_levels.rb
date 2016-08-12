class CreateRpmModifierLevels < ActiveRecord::Migration
  def change
    create_table :rpm_modifier_levels do |t|
      t.references :rpm_modifier, index: true
      t.string :description
      t.integer :cost
      t.boolean :include_notes_in_summary
      t.boolean :accepts_enhancements

      t.timestamps null: false
    end
    add_foreign_key :rpm_modifier_levels, :rpm_modifiers
  end
end
