require 'test_helper'

class EquipmentPieceTest < ActiveSupport::TestCase
  setup do
    @type = FactoryGirl.build(:equipment_type)
    @piece = EquipmentPiece.new(:name => "Test piece", :equipment_type => @type)
  end

  test "values populate when accessed" do
    assert_equal @type.base_cost, @piece.base_cost
    assert_equal @type.base_cost, @piece.cost
    assert_equal @type.base_weight, @piece.base_weight
    assert_equal @type.base_weight, @piece.weight
  end

  test "values change when modifiers are added" do
    assert_equal 10, @type.base_cost.dollars.to_i
    assert_equal 10, @piece.cost.dollars.to_i
    @piece.equipment_modifiers << EquipmentModifier.new(:name => "Supercool", :cost_mod => "+4 CF")
    #@piece.cost_cents = nil
    assert_equal 5000, @piece.cost_cents
    assert_equal 50, @piece.cost.dollars.to_i
  end
end