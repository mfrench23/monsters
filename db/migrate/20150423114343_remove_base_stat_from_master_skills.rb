class RemoveBaseStatFromMasterSkills < ActiveRecord::Migration
  def change
    remove_column :master_skills, :baseStat, :integer
  end
end
