class RemoveDescriptionFromRpmRitualVariant < ActiveRecord::Migration[5.0]
  def change
    remove_column :rpm_ritual_variants, :description, :text
  end
end
