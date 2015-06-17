require 'test_helper'

class TraitListTest < ActiveSupport::TestCase
  setup do
  end

  test "converts items delimited by commas in various formats" do
    a = "Fearlessness 3 [15], Callous [-5], Combat Reflexes [15]"
    b = "Fearlessness (Magical, -10%) 3 [15], Callous [-5], Combat Reflexes [15]"
    c = "Fearlessness 3 (Magical, -10%) [15], Callous, Combat Reflexes."
    [a, b, c].each do |variation|
      traits = Creature::TraitList::FreeformTraitList.new(variation).list
      assert_equal traits.count, 3, variation

      trait = traits.first # expecting alphabetical order
      assert_equal "Callous", trait.master_trait_name, variation
      assert_nil trait.level, variation

      trait = traits.second
      assert_equal "Combat Reflexes", trait.master_trait_name, variation
      assert_nil trait.level, variation

      trait = traits.last
      assert_equal "Fearlessness", trait.master_trait_name, variation
      assert_equal trait.level, 3, variation
    end
  end
end