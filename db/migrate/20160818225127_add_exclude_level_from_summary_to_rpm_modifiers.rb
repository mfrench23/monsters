class AddExcludeLevelFromSummaryToRpmModifiers < ActiveRecord::Migration
  def change
    add_column :rpm_modifiers, :exclude_level_from_summary, :boolean
  end
end
