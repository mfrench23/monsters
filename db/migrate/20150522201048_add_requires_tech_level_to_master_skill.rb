class AddRequiresTechLevelToMasterSkill < ActiveRecord::Migration
  def change
    add_column :master_skills, :requires_tech_level, :boolean
  end
end
