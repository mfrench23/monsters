require 'test_helper'

class EquipmentTypesControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryBot.create(:campaign)
    @eq_category = EquipmentCategory.new(:name => "Knickknacks", :campaign => @campaign)
    @eq_category.save!
    @equipment_type = EquipmentType.new(:name => "Rather Narrow Sword", :base_cost_cents => 1000, 
                                        :base_weight => 9.99, :random_weight => 1, :campaign => @campaign,
                                        :equipment_category => @eq_category)
    @equipment_type.save!

    @campaign2 = FactoryBot.create(:campaign, :name => @campaign.name + "-2")
    @eq_category2 = EquipmentCategory.new(:name => "Knickknacks Part 2, The Revenge", :campaign => @campaign2)
    @eq_category2.save!

    cookies[:selected_campaign] = @campaign.id.to_s
  end

  test "should restrict autocomplete by campaign" do
    get :autocomplete_equipment_category_name, params: { :term => "Knick" }
    assert_response :ok
    body = JSON.parse @response.body
    assert_equal 1, body.count
    assert_equal @eq_category.id.to_s, body.first["id"].to_s
  end

  test "should restrict autocomplete by campaign, part 2" do
    cookies[:selected_campaign] = @campaign2.id.to_s # change campaign, change the results
    get :autocomplete_equipment_category_name, params: { :term => "Knick" }
    assert_response :ok
    body = JSON.parse @response.body
    assert_equal 1, body.count
    assert_equal @eq_category2.id.to_s, body.first["id"].to_s
  end

  test "should get index" do
    get :index
    assert_response :ok
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should fail to create equipment_type with duplicate name" do
    name = @equipment_type.name
    assert_no_difference('EquipmentType.count') do
      post :create, params: { equipment_type: { base_cost: @equipment_type.base_cost,
                                      base_weight: @equipment_type.base_weight,
                                      equipment_category_id: @equipment_type.equipment_category_name,
                                      name: name, notes: @equipment_type.notes } }
    end

    assert_response :ok
  end

  test "should show equipment_type" do
    get :show, params: { id: @equipment_type }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @equipment_type }
    assert_response :success
    assert_select "span", { :text => "Equipment Modifier Categories" }
  end

  test "should redirect to index when showing an equipment_type from another campaign" do
    cookies[:selected_campaign] = (cookies[:selected_campaign].to_i + 1).to_s
    get :edit, params: { id: @equipment_type }
    assert_redirected_to equipment_types_path
    get :show, params: { id: @equipment_type }
    assert_redirected_to equipment_types_path
  end

  test "should update equipment_type" do
    patch :update, params: { id: @equipment_type, equipment_type: { base_cost_cents: @equipment_type.base_cost_cents, base_weight: @equipment_type.base_weight, equipment_category_name: @equipment_type.equipment_category_name, name: @equipment_type.name, notes: @equipment_type.notes } }
    assert_redirected_to @equipment_type
  end

  test "should fail to update" do
    patch :update, params: { id: @equipment_type, equipment_type: { base_cost_cents: nil, base_weight: nil, equipment_category_id: nil, name: nil } }
    assert_response 200
  end

  test "should destroy equipment_type" do
    @request.env['HTTP_REFERER'] = equipment_types_path
    assert_difference('EquipmentType.count', -1) do
      delete :destroy, params: { id: @equipment_type }
    end

    assert_redirected_to equipment_types_path
  end
end
