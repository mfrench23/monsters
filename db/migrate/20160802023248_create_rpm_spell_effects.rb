class CreateRpmSpellEffects < ActiveRecord::Migration
  def change
    create_table :rpm_spell_effects do |t|
      t.references :rpm_ritual, index: false
      t.references :rpm_potency, index: true
      t.references :rpm_effect, index: true
      t.references :rpm_path, index: true
      t.text :notes
      t.boolean :inherent

      t.timestamps null: false
    end
    add_index :rpm_spell_effects, [:rpm_ritual_id, :inherent]
    add_foreign_key :rpm_spell_effects, :rpm_rituals
    add_foreign_key :rpm_spell_effects, :rpm_potencies
    add_foreign_key :rpm_spell_effects, :rpm_effects
    add_foreign_key :rpm_spell_effects, :rpm_paths
  end
end
