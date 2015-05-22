class AddTechLevelToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :tech_level, :string
  end
end
