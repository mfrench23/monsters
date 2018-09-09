class CreateRpmRitualVariantModifiers < ActiveRecord::Migration[5.0]
  def change
    create_table :rpm_ritual_variant_modifiers do |t|
      t.references :rpm_ritual_variant, foreign_key: true
      t.references :rpm_modifier_level, foreign_key: true
      t.text :notes
      t.integer :enhancement_percentage
      t.text :enhancement_notes
      t.references :rpm_modifier_subtype, foreign_key: true
      t.boolean :enhancement_only

      t.timestamps
    end
  end
end
