class AddCharacteristicsToMasterSkill < ActiveRecord::Migration
  def change
    add_reference :master_skills, :characteristic, index:true
    add_foreign_key :master_skills, :characteristics
  end
end
