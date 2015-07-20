class RemoveMonsterIdFromPageReference < ActiveRecord::Migration
  def change
    remove_foreign_key :page_references, "monsters"
    remove_column :page_references, :monster_id, :integer
  end
end
