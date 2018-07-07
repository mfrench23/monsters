require 'test_helper'

class RpmRitualTest < ActiveSupport::TestCase
  test "calc_effective_skill" do
    assert_equal 23, RpmRitual.calc_effective_skill(95)
    assert_equal 22, RpmRitual.calc_effective_skill(94)
    assert_equal 12, RpmRitual.calc_effective_skill(6)
    assert_equal 11, RpmRitual.calc_effective_skill(5)
  end
end
