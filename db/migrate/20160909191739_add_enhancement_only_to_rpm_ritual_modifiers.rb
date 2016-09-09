class AddEnhancementOnlyToRpmRitualModifiers < ActiveRecord::Migration
  def change
    add_column :rpm_ritual_modifiers, :enhancement_only, :boolean
  end
end
