require 'test_helper'

class MasterTraitTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.build(:master_trait)
    @two = FactoryGirl.build(:master_trait, is_feature: true)
    @three = FactoryGirl.build(:master_trait, notes: "Fragile")
  end

  test "to_s" do
    assert_equal "Wombat Reflexes", @one.to_s
    assert_equal "Feature: Wombat Reflexes", @two.to_s
    assert_equal "Wombat Reflexes (Fragile)", @three.to_s
  end
end
