class RemoveCreatureAndMetaTraitIdFromTrait < ActiveRecord::Migration
  def up
    remove_foreign_key :traits, :creatures
    remove_foreign_key :traits, :meta_traits
    remove_column :traits, :creature_id, :integer
    remove_column :traits, :meta_trait_id, :integer
  end

  def down
    add_column :traits, :creature_id, :integer
    add_column :traits, :meta_trait_id, :integer
    add_foreign_key "traits", "creatures"
    add_foreign_key "traits", "master_traits", column: "meta_trait_id"
  end
end
