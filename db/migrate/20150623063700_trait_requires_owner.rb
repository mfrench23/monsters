class TraitRequiresOwner < ActiveRecord::Migration
  def change
    change_column_null :traits, :trait_owner_type, false
    change_column_null :traits, :trait_owner_id, false
  end
end
