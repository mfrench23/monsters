require 'test_helper'

class EquipmentTypesControllerTest < ActionController::TestCase
  setup do
    @equipment_type = FactoryGirl.create(:equipment_type)
  end

  test "should get index" do
    get :index
    assert_response :ok
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create equipment_type" do
    name = @equipment_type.name + " Too"
    assert_difference('EquipmentType.count') do
      post :create, equipment_type: { base_cost: @equipment_type.base_cost,
                                      base_weight: @equipment_type.base_weight,
                                      equipment_category_id: @equipment_type.equipment_category_id,
                                      name: name, notes: @equipment_type.notes }
    end

    assert_response :found
    equipment_type = EquipmentType.where(:name => name ).order("created_at desc").first
    assert_not_nil equipment_type
    assert_redirected_to equipment_type
  end

  test "should fail to create equipment_type with duplicate name" do
    name = @equipment_type.name
    assert_no_difference('EquipmentType.count') do
      post :create, equipment_type: { base_cost: @equipment_type.base_cost,
                                      base_weight: @equipment_type.base_weight,
                                      equipment_category_id: @equipment_type.equipment_category_id,
                                      name: name, notes: @equipment_type.notes }
    end

    assert_response :ok
  end

  test "should show equipment_type" do
    get :show, id: @equipment_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipment_type
    assert_response :success
  end

  test "should update equipment_type" do
    patch :update, id: @equipment_type, equipment_type: { base_cost_cents: @equipment_type.base_cost_cents, base_weight: @equipment_type.base_weight, equipment_category_id: @equipment_type.equipment_category_id, name: @equipment_type.name, notes: @equipment_type.notes }
    assert_redirected_to @equipment_type
  end

  test "should destroy equipment_type" do
    assert_difference('EquipmentType.count', -1) do
      delete :destroy, id: @equipment_type
    end

    assert_redirected_to equipment_types_path
  end
end
