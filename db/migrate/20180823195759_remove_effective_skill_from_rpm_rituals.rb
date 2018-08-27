class RemoveEffectiveSkillFromRpmRituals < ActiveRecord::Migration[5.0]
  def change
    remove_column :rpm_rituals, :effective_skill, :integer
  end
end
