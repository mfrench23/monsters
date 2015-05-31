require 'test_helper'

class TraitListTest < ActiveSupport::TestCase
  setup do
  end

  test "converts items delimited by commas" do
    traits = Creature::TraitList::FreeformTraitList.new("Fearlessness 3 [15], Combat Reflexes [15]").list
    assert_equal 2, traits.count
    trait = traits.first
    assert_equal 3, trait.level
    assert_equal "Fearlessness", trait.master_trait.name
    trait = traits.last
    assert_nil trait.level
    assert_equal "Combat Reflexes", trait.master_trait.name
  end
end