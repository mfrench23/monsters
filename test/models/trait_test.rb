require 'test_helper'

class TraitTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.build(:trait)
    @two = FactoryGirl.build(:trait, level: 3)
    @master = FactoryGirl.build(:master_trait, is_feature: true)
    @three = FactoryGirl.build(:trait, master_trait: @master)
  end

  test "to_s" do
    assert_equal "Wombat Reflexes", @one.to_s
    assert_equal "Wombat Reflexes 3", @two.to_s
    assert_equal "Feature: Wombat Reflexes", @three.to_s
  end

end
