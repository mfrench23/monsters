class RemoveMasterTraitIdFromTraits < ActiveRecord::Migration
  def change
    remove_column :traits, :masterTrait_id, :integer
  end
end
