require 'test_helper'

class DamageResistancesHelperTest < ActionView::TestCase
  setup do
    @one = FactoryGirl.build(:damage_resistance)
    
    loc = FactoryGirl.build(:location, name: "Tail")
    @two = FactoryGirl.build(:damage_resistance, location: loc, dr: 2, notes: "Flexible")
    @three = FactoryGirl.build(:damage_resistance, location: nil, dr: 3)
    @four = FactoryGirl.build(:damage_resistance, location: nil, dr: 4, notes: "wooden")
  end

  test "should format correctly with a location" do
    assert_equal "Skull: 1", simpleDR(@one)
  end
  test "should format correctly with a location and a note" do
    assert_equal "Tail: 2 (Flexible)", simpleDR(@two)
  end
  test "should format correctly with just DR alone" do
    assert_equal "3", simpleDR(@three)
  end
  test "should format correctly with DR and note alone" do
    assert_equal "4 (wooden)", simpleDR(@four)
  end
end