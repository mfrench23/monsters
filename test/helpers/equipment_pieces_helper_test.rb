require 'test_helper'

class EquipmentPiecesHelperTest < ActionView::TestCase
  test "should correctly format" do
    ty = EquipmentType.new(:name => "Knife", :base_cost => 5, :base_weight => 1)
    ep = EquipmentPiece.new(:equipment_type => ty)
    assert_equal "Knife ($5.00; 1#)", pretty_print_equipment_piece(ep)
    ep.name = "Mini-Excalibur"
    assert_equal "Mini-Excalibur: Knife ($5.00; 1#)", pretty_print_equipment_piece(ep)
    ep.equipment_modifiers << EquipmentModifier.new(:name => "Fine", :cost_mod => "+1 CF")
    assert_equal "Mini-Excalibur: Knife (Fine; $10.00; 1#)", pretty_print_equipment_piece(ep)
    ep.equipment_modifiers << EquipmentModifier.new(:name => "Extra-Fine", :cost_mod => "+1 CF")
    assert_equal "Mini-Excalibur: Knife (Fine, Extra-Fine; $15.00; 1#)", pretty_print_equipment_piece(ep)
  end
end