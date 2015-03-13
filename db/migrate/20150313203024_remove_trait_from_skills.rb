class RemoveTraitFromSkills < ActiveRecord::Migration
  def change
    remove_column :skills, :trait, :string
  end
end
