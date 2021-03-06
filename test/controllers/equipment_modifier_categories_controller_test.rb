require 'test_helper'

class EquipmentModifierCategoriesControllerTest < ActionController::TestCase
  setup do
    campaign = Campaign.new(:name => "EQModCat Campaign")
    campaign.save!
    @equipment_modifier_category = EquipmentModifierCategory.new( :name => "EqModCat", :notes => "Some notes")
    equipment_category = EquipmentCategory.new(:name => "Eq Cat", :campaign => campaign)
    equipment_category.save!
    type = EquipmentType.new( :name => "Dice bag", :base_cost_cents => 100, :campaign => campaign, :equipment_category => equipment_category )
    type.save!
    @equipment_modifier_category.equipment_types << type
    @equipment_modifier_category.save!
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

  test "should create equipment_modifier_category" do
    name = "New Lame Eq Modifier Category"

    assert_difference('EquipmentModifierCategory.count') do
      post :create, params: { equipment_modifier_category: { name: name } }
    end

    assert_response :found
    equipment_modifier_category = EquipmentModifierCategory.where(:name => name ).order("created_at desc").first
    assert_not_nil equipment_modifier_category
    assert_redirected_to equipment_modifier_category
  end

  test "should show equipment_modifier_category" do
    get :show, params: { id: @equipment_modifier_category }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @equipment_modifier_category }
    assert_response :success
  end

  test "should update equipment_modifier_category" do
    patch :update, params: { id: @equipment_modifier_category, equipment_modifier_category: { name: @equipment_modifier_category.name + "2", notes: @equipment_modifier_category.notes } }
    assert_redirected_to @equipment_modifier_category
  end

  test "should destroy equipment_modifier_category" do
    @request.env['HTTP_REFERER'] = equipment_modifier_categories_path
    assert_difference('EquipmentModifierCategory.count', -1) do
      delete :destroy, params: { id: @equipment_modifier_category }
    end

    assert_redirected_to equipment_modifier_categories_path
  end
end
