class AddBaseStatToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :baseStat, :integer
    add_index :skills, :baseStat
  end
end
