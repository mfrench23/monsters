class AddMasterSkillToSkill < ActiveRecord::Migration
  def change
    add_reference :skills, :master_skill, index: true
    add_foreign_key :skills, :master_skills
  end
end
