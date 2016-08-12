class AddRpmModifierSubtypeToRpmRitualModifier < ActiveRecord::Migration
  def change
    add_reference :rpm_ritual_modifiers, :rpm_modifier_subtype, index: true
    add_foreign_key :rpm_ritual_modifiers, :rpm_modifier_subtypes
  end
end
