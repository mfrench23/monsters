require 'test_helper'

class EquipmentCategoriesControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryGirl.create(:campaign)
    @equipment_category = EquipmentCategory.new(:name => "Knickknacks", :campaign => @campaign )
    @equipment_category.save!
    cookies[:selected_campaign] = @campaign.id.to_s
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should fail to create equipment_category with duplicate name" do
    assert_no_difference('EquipmentCategory.count') do
      post :create, equipment_category: { name: @equipment_category.name }
    end

    assert_response 200
  end

  test "should create equipment_category" do
    name = @equipment_category.name + " Again"

    assert_difference('EquipmentCategory.count') do
      post :create, equipment_category: { name: name }
    end

    assert_response :found
    equipment_category = EquipmentCategory.where(:name => name ).order("created_at desc").first
    assert_not_nil equipment_category
    assert_redirected_to equipment_category
  end

  test "should show equipment_category" do
    get :show, id: @equipment_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipment_category
    assert_response :success
  end

  test "should update equipment_category" do
    patch :update, id: @equipment_category, equipment_category: { name: @equipment_category.name, campaign_id: @equipment_category.campaign.id }
    assert_redirected_to @equipment_category
  end

  test "should fail to update" do
    patch :update, id: @equipment_category, equipment_category: { name: nil }
    assert_response 200
  end

  test "should destroy equipment_category" do
    @request.env['HTTP_REFERER'] = equipment_categories_path
    assert_difference('EquipmentCategory.count', -1) do
      delete :destroy, id: @equipment_category
    end

    assert_redirected_to equipment_categories_path
  end
end
