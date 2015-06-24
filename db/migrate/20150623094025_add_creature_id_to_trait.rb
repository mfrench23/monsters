class AddCreatureIdToTrait < ActiveRecord::Migration
  class Trait < ActiveRecord::Base
  end

  def up
    add_reference :traits, :creature, index: true
    add_foreign_key :traits, :creatures
    Trait.where(:trait_owner_type => 'Creature').find_each do |trait|
      trait.creature_id = trait.trait_owner_id
      trait.save
    end
  end

  def down
    remove_foreign_key :traits, :creatures
    remove_reference :traits, :creature, index: true
  end
end
