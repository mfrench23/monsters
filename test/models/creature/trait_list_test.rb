require 'test_helper'

class TraitListTest < ActiveSupport::TestCase
  setup do
  end

  test "converts items delimited by commas" do
    a = "Fearlessness 3 [15], Combat Reflexes [15]"
    b = "Fearlessness (Magical, -10%) 3 [15], Combat Reflexes [15]"
    c = "Fearlessness 3 (Magical, -10%) [15], Combat Reflexes."
    [a, b, c].each do |variation|
      traits = Creature::TraitList::FreeformTraitList.new(variation).list
      trait = traits.first # expecting alphabetical order
      assert_equal "Combat Reflexes", trait.master_trait.name, variation
      assert_nil trait.level, variation
      trait = traits.last
      assert_equal "Fearlessness", trait.master_trait.name, variation
      assert_equal traits.count, 2, variation
      assert_equal trait.level, 3, variation
    end
  end
end