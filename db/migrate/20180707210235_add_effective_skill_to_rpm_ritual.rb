class AddEffectiveSkillToRpmRitual < ActiveRecord::Migration[5.0]
  def change
    add_column :rpm_rituals, :effective_skill, :integer
  end
end
