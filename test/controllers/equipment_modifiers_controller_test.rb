require 'test_helper'

class EquipmentModifiersControllerTest < ActionController::TestCase
  setup do
    @equipment_modifier = FactoryGirl.create(:equipment_modifier)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should show equipment_modifier" do
    get :show, id: @equipment_modifier
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipment_modifier
    assert_response :success
  end

  test "should update equipment_modifier" do
    patch :update, id: @equipment_modifier, equipment_modifier: { base_cost_mod: @equipment_modifier.base_cost_mod, base_weight_mod: @equipment_modifier.base_weight_mod, cost_mod: @equipment_modifier.cost_mod, equipment_modifier_category_id: @equipment_modifier.equipment_modifier_category_id, name: @equipment_modifier.name, notes: @equipment_modifier.notes, weight_mod: @equipment_modifier.weight_mod }
    assert_redirected_to @equipment_modifier
  end

  test "should destroy equipment_modifier" do
    assert_difference('EquipmentModifier.count', -1) do
      delete :destroy, id: @equipment_modifier
    end

    assert_redirected_to equipment_modifiers_path
  end
end