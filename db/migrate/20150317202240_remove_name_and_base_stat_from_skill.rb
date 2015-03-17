class RemoveNameAndBaseStatFromSkill < ActiveRecord::Migration
  def change
    remove_column :skills, :name, :string
    remove_column :skills, :baseStat, :integer
  end
end
