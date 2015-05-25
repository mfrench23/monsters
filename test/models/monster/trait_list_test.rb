require 'test_helper'

class TraitListTest < ActiveSupport::TestCase
  setup do
  end

  test "converts items delimited by commas" do
    traits = Monster::TraitList::FreeformTraitList.new("Fearlessness 3, Combat Reflexes").list
    assert_equal 2, traits.count
    trait = traits.first
    assert_equal 3, trait.level
    assert_equal "Fearlessness", trait.master_trait.name
  end
end