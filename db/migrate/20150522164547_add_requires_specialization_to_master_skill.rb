class AddRequiresSpecializationToMasterSkill < ActiveRecord::Migration
  def change
    add_column :master_skills, :requires_specialization, :boolean
  end
end
