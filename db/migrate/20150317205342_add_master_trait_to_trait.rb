class AddMasterTraitToTrait < ActiveRecord::Migration
  def change
    add_reference :traits, :master_trait, index: true
    add_foreign_key :traits, :master_traits
  end
end
