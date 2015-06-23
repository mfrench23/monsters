class AllowTraitsWithoutCreatureIds < ActiveRecord::Migration
  def change
    change_column :traits, :creature_id, :integer, :null => true
  end
end
