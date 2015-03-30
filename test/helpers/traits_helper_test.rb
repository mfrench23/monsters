require 'test_helper'

class TraitsHelperTest < ActionView::TestCase
  setup do
    @one = FactoryGirl.create(:trait)
    @two = FactoryGirl.create(:trait, level: 3)
    @master = FactoryGirl.create(:master_trait, is_feature: true)
    @three = FactoryGirl.create(:trait, master_trait: @master)
  end

  test "should format traits" do
    assert_equal "Wombat Reflexes", simpleTrait(@one)
    assert_equal "Wombat Reflexes 3", simpleTrait(@two)
    assert_equal "Feature: Wombat Reflexes", simpleTrait(@three)
  end
end