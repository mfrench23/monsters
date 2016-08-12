class AddInherentToRpmRitualModifier < ActiveRecord::Migration
  def change
    add_column :rpm_ritual_modifiers, :inherent, :boolean
  end
end
