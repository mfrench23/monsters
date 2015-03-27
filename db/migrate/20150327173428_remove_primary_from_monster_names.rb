class RemovePrimaryFromMonsterNames < ActiveRecord::Migration
  def change
    remove_column :monster_names, :primary, :boolean
  end
end
