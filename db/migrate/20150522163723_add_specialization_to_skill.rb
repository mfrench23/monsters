class AddSpecializationToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :specialization, :string
  end
end
