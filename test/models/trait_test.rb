require 'test_helper'

class TraitTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.create(:trait)
    @two = FactoryGirl.create(:trait, level: 3)
    @master = FactoryGirl.create(:master_trait, is_feature: true)
    @three = FactoryGirl.create(:trait, master_trait: @master)
  end

  test "to_s" do
    assert_equal "Wombat Reflexes", @one.to_s
    assert_equal "Wombat Reflexes 3", @two.to_s
    assert_equal "Feature: Wombat Reflexes", @three.to_s
  end

end
