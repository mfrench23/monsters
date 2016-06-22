require 'test_helper'

class EquipmentModifierSupercategoriesControllerTest < ActionController::TestCase
  setup do
    @equipment_modifier_supercategory = FactoryGirl.create(:equipment_modifier_supercategory)
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

  test "should create equipment_modifier_supercategory" do
    name = "New Eq Modifier Sooper-Category"

    assert_difference('EquipmentModifierSupercategory.count') do
      post :create, equipment_modifier_supercategory: { name: name }
    end

    assert_response :found
    equipment_modifier_supercategory = EquipmentModifierSupercategory.where(:name => name ).order("created_at desc").first
    assert_not_nil equipment_modifier_supercategory
    assert_redirected_to equipment_modifier_supercategory    
  end

  test "should show equipment_modifier_supercategory" do
    get :show, id: @equipment_modifier_supercategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipment_modifier_supercategory
    assert_response :success
  end

  test "should update equipment_modifier_supercategory" do
    patch :update, id: @equipment_modifier_supercategory, equipment_modifier_supercategory: { name: @equipment_modifier_supercategory.name + "2" }
    assert_redirected_to @equipment_modifier_supercategory
  end

  test "should destroy equipment_modifier_supercategory" do
    @request.env['HTTP_REFERER'] = equipment_modifier_supercategories_path
    assert_difference('EquipmentModifierSupercategory.count', -1) do
      delete :destroy, id: @equipment_modifier_supercategory
    end

    assert_redirected_to equipment_modifier_supercategories_path
  end
end
