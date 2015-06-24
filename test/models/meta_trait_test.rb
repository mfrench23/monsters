require 'test_helper'

class MetaTraitTest < ActiveSupport::TestCase
  setup do
    @master_meta = FactoryGirl.build(:master_trait, :name => 'Golden Age Super')
    @master_member1 = FactoryGirl.create(:master_trait, :name => 'Kirby Crackle')
    @master_member2 = FactoryGirl.create(:master_trait, :name => 'Strong Jaw')
    @master_meta.traits_in_meta_trait << FactoryGirl.build(:trait, :master_trait => @master_member1, :level => 2)
    @master_meta.traits_in_meta_trait << FactoryGirl.build(:trait, :master_trait => @master_member2)
    @master_meta.save
    @master_trait_nonmember = FactoryGirl.create(:master_trait, :name => 'Moral Code')
  end

  test "meta-trait creates dependant traits on the same character" do
    creature = FactoryGirl.create(:creature)
    # adding a meta-trait to a creature adds all the component traits that make up that meta-trait
    assert_difference( "Creature.find(#{creature.id}).flattened_traits.count", 3) do
      creature.traits << Trait.new(:master_trait => @master_meta)
      creature.save
    end
    assert_equal 1, creature.traits.count # just the meta trait
    # removal of meta-trait also removes granted traits
    assert_difference( "Creature.find(#{creature.id}).flattened_traits.count", -3) do
      creature.traits.first.destroy
      creature.save
    end
    assert_equal 0, creature.traits.count
  end

  test "meta-trait changes are reflected in traits" do
    creature = FactoryGirl.create(:creature)
    creature.traits << Trait.new(:master_trait => @master_meta)
    creature.save
    # adding a new trait to the meta-trait also adds the new trait to the character with the meta-trait
    assert_difference( "Creature.find(#{creature.id}).flattened_traits.count", 1) do
      @master_meta.traits_in_meta_trait << Trait.new(master_trait: @master_trait_nonmember, notes: "Cosmic")
      @master_meta.save
    end
    # removing a trait is also reflected on the character
    assert_difference( "Creature.find(#{creature.id}).flattened_traits.count", -1) do
      @master_meta.traits_in_meta_trait.first.destroy
      @master_meta.save
    end
  end
end
