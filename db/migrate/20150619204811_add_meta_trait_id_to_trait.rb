class AddMetaTraitIdToTrait < ActiveRecord::Migration
  def change
    add_reference :traits, :meta_trait, index: true
    add_foreign_key :traits, :master_traits, column: :meta_trait_id
  end
end
