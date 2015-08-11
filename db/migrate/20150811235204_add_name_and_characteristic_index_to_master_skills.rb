class AddNameAndCharacteristicIndexToMasterSkills < ActiveRecord::Migration
  def change
    add_index :master_skills, [:name, :characteristic_id], name: "index_master_skills_on_name_characteristic_id", unique: true
  end
end
