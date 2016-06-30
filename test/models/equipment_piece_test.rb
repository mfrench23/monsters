require 'test_helper'

class EquipmentPieceTest < ActiveSupport::TestCase
  setup do
    @campaign = FactoryGirl.create(:campaign)
    @eq_category = EquipmentCategory.new(:name => "Knickknacks", :campaign => @campaign)
    @eq_category.save!
    @type = EquipmentType.new(:name => "Kinda Narrow Sword", :base_weight => 9.99, :base_cost_cents => 1000)
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
    assert_equal 5000, @piece.cost_cents
    assert_equal 50, @piece.cost.dollars.to_i
  end

  test "values change when a modifier is changed" do
    type = EquipmentType.new(:name => "Garbage Type", :base_weight => 1, :base_cost_cents => 100, :equipment_category => @eq_category, :random_weight => 1, :campaign => @campaign)
    type.save!
    mod = EquipmentModifier.new(:name => "Fancy!", :cost_mod => "+49 CF", :random_weight => 1)
    mod.save!
    piece = EquipmentPiece.new(:equipment_type => type, :quantity => 1)
    piece.equipment_modifiers << mod
    piece.save!
    id = piece.id
    assert_equal 50, piece.cost.dollars.to_i
    mod.cost_mod = "+9 CF"
    mod.save!
    piece = EquipmentPiece.find(id)
    assert_equal 10, piece.cost.dollars.to_i
  end
end
