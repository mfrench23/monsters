require 'test_helper'

class TraitsHelperTest < ActionView::TestCase
  setup do
    @one = traits(:one)
    @two = traits(:two)
    @cannot_swim = traits(:cannot_swim)
  end
  
  test "should format traits" do
    assert_equal "Catlike Reflexes", simpleTrait(@one)
    assert_equal "Geek Level (Arcane) 3", simpleTrait(@two)
    assert_equal "Feature: Cannot Swim", simpleTrait(@cannot_swim)
  end
end