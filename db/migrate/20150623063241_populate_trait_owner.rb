class PopulateTraitOwner < ActiveRecord::Migration
  class Trait < ActiveRecord::Base
  end

  def up
    Trait.find_each do |trait|
      if ! trait.creature_id.nil?
        trait.trait_owner_id = trait.creature_id
        trait.trait_owner_type = 'Creature'
      elsif ! trait.meta_trait_id.nil?
        trait.trait_owner_id = trait.meta_trait_id
        trait.trait_owner_type = 'MetaTrait'
      end
      trait.save
    end
  end

  def down
    Trait.find_each do |trait|
      if trait.trait_owner_type = 'Creature'
        trait.creature_id = trait.trait_owner_id
      elsif trait.trait_owner_type = 'MetaTrait'
        trait.meta_trait_id = trait.trait_owner_id
      end
      trait.save
    end
  end
end
