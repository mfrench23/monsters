require 'test_helper'

class EquipmentModifierTest < ActiveSupport::TestCase
  setup do
    @mod = EquipmentModifier.new(:name => "Nice", 
                                 :base_cost_mod => "+100", 
                                 :base_weight_mod => "+10 lbs.", 
                                 :cost_mod => "+1.5 CF", 
                                 :weight_mod => "x9/10")
  end

  test "to_s" do
    assert_equal "Nice (base cost +$100.00, base weight +10#, +1.5 CF, x0.9 wt)", @mod.to_s
  end

  test "to_s with multiplier" do
    @mod.base_cost_mod = "x2"
    @mod.weight_mod = "+15#"
    assert_equal "Nice (base cost x2, base weight +10#, +1.5 CF, +15# wt)", @mod.to_s
  end

  test "to_s with empty slots" do
    @mod.base_cost_mod = nil
    @mod.weight_mod = ""
    assert_equal "Nice (base weight +10#, +1.5 CF)", @mod.to_s
  end

  test "factor of 1 when not multiplying" do
    assert_equal 1, @mod.modifier_value_object(:base_cost).factor
  end

  test "does math when handed a fractional factor" do
    assert_equal 0.9, @mod.modifier_value_object(:weight).factor
  end

  test "additive modifiers" do
    original_base_cost = Money.new(5000)
    assert_equal Money.new(10000), @mod.modifier_value_object(:base_cost).addition(original_base_cost)
  end

  test "CF modifier" do
    original_base_cost = Money.new(5000)
    assert_equal Money.new(7500), @mod.modifier_value_object(:cost).addition(original_base_cost)
  end

  test "Money for money" do
    mod = EquipmentModifier.new(:name => "Empty")
    assert_equal Money.new(0), mod.modifier_value_object(:base_cost).addition(nil)
    assert_equal Money.new(0), mod.modifier_value_object(:cost).addition(nil)
    mod.base_cost_mod = mod.cost_mod = "+$100"
    assert_equal Money.new(10000), mod.modifier_value_object(:base_cost).addition(nil)
    assert_equal Money.new(10000), mod.modifier_value_object(:cost).addition(nil)
    assert_equal "+$100.00", mod.modifier_value_object(:cost).to_s
    mod.base_cost_mod = mod.cost_mod = "+100"
    assert_equal Money.new(10000), mod.modifier_value_object(:base_cost).addition(nil)
    assert_equal Money.new(10000), mod.modifier_value_object(:cost).addition(nil)
    assert_equal "+$100.00", mod.modifier_value_object(:cost).to_s
  end
end
