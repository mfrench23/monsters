class AddEnhancementNotesToRpmRitualModifier < ActiveRecord::Migration
  def change
    add_column :rpm_ritual_modifiers, :enhancement_notes, :text
  end
end
