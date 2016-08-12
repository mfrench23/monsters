class CreateRpmModifierSubtypes < ActiveRecord::Migration
  def change
    create_table :rpm_modifier_subtypes do |t|
      t.references :rpm_modifier, index: true
      t.string :name
      t.decimal :multiplier, :precision => 5, :scale => 2

      t.timestamps null: false
    end
    add_foreign_key :rpm_modifier_subtypes, :rpm_modifiers
  end
end
