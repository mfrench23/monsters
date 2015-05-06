require 'test_helper'

class DamageResistancesHelperTest < ActionView::TestCase
  setup do
    @one = FactoryGirl.create(:damage_resistance)
    
    loc = FactoryGirl.create(:location, name: "Tail")
    @two = FactoryGirl.create(:damage_resistance, location: loc, dr: 2, notes: "Flexible")
  end

  test "should format correctly" do
    assert_equal "Skull: 1", simpleDR(@one)
    assert_equal "Tail: 2 (Flexible)", simpleDR(@two)
  end
end