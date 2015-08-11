require 'test_helper'

class DamageResistancesHelperTest < ActionView::TestCase
  test "should format correctly with a location" do
    assert_equal "skull: 1", simpleDR(DamageResistance.new(:location => Location.find_by(:name => 'skull'), :dr => 1))
  end

  test "should format correctly with a location and a note" do
    assert_equal "skull: 2 (Flexible)", simpleDR(DamageResistance.new(:location => Location.find_by(:name => 'skull'), :dr => 2, :notes => 'Flexible'))
  end
  test "should format correctly with just DR alone" do
    assert_equal "3", simpleDR(DamageResistance.new(:dr => 3))
  end
  test "should format correctly with DR and note alone" do
    assert_equal "4 (wooden)", simpleDR(DamageResistance.new(:dr => 4, :notes => 'wooden'))
  end
end