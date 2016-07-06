require 'test_helper'

class EquipmentPiecesHelperTest < ActionView::TestCase
  test "should correctly format individual items" do
    ty = EquipmentType.new(:name => "Knife", :base_cost => 5, :base_weight => 1)
    ep = EquipmentPiece.new(:equipment_type => ty, :quantity => 1)
    assert_equal "Knife (1#, $5.00)", pretty_print_equipment_piece(ep)
    ep.name = "Mini-Excalibur"
    assert_equal "Mini-Excalibur: Knife (1#, $5.00)", pretty_print_equipment_piece(ep)
    ep.equipment_modifiers << EquipmentModifier.new(:name => "Fine", :cost_mod => "+1 CF")
    assert_equal "Mini-Excalibur: Knife (Fine; 1#, $10.00)", pretty_print_equipment_piece(ep)
    ep.equipment_modifiers << EquipmentModifier.new(:name => "Extra-Fine", :cost_mod => "+1 CF")
    assert_equal "Mini-Excalibur: Knife (Fine; Extra-Fine; 1#, $15.00)", pretty_print_equipment_piece(ep)
    ep.quantity = 3
    assert_equal "Mini-Excalibur: 3 Knives (Fine; Extra-Fine; each 1#, $15.00; total 3#, $45.00)", pretty_print_equipment_piece(ep)
  end

  test "should correctly format groups of items" do
    ty = EquipmentType.new(:name => "Beer", :unit_of_measurement => "pint", :base_cost => 5, :base_weight => 1)
    ep = EquipmentPiece.new(:equipment_type => ty, :quantity => 6)
    assert_equal "6 pints Beer (each 1#, $5.00; total 6#, $30.00)", pretty_print_equipment_piece(ep)
  end
end