class AddPolymorphicOwnerToTrait < ActiveRecord::Migration
  def change
    add_column :traits, :trait_owner_id, :integer
    add_column :traits, :trait_owner_type, :string
    add_index :traits, [:trait_owner_id, :trait_owner_type]
  end
end
