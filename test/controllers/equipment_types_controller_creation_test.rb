require 'test_helper'

class EquipmentTypesControllerCreationTest < ActionController::TestCase
  setup do
    @controller = EquipmentTypesController.new
    @campaign = FactoryBot.create(:campaign)
    eq_category = EquipmentCategory.new(:name => "Knickknacks", :campaign => @campaign)
    eq_category.save!
    @equipment_type = EquipmentType.new(:name => "Rather Narrow Sword", :base_cost_cents => 1000, 
                                        :base_weight => 9.99, :random_weight => 1, :campaign => @campaign,
                                        :equipment_category => eq_category)
    @equipment_type.save!
    cookies[:selected_campaign] = @campaign.id.to_s
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get mass entry page" do
    get :mass_entry
    assert_response :success
  end

  test "should do mass entry" do
    assert_difference('EquipmentType.count', 1) do
      post :do_mass_entry, params: {:equipment_category_name => "Weapons",
                              :campaign_id => @campaign.id,
                              :freeform_text => "\nBig Stick ($5.50; 2.1#)\n\n"}
      assert_response :found
    end
    type = EquipmentType.find_by(:name => "Big Stick")
    assert_equal "5.50", type.base_cost.to_s
    assert_equal "2.1", "%g" % type.base_weight
    assert_equal "Weapons", type.equipment_category_name
    assert_equal @campaign.id, type.campaign_id
  end

  test "should refuse to do mass entry" do
    assert_no_difference('EquipmentType.count') do
      post :do_mass_entry, params: {:equipment_category_name => "",
                              :freeform_text => "Big Stick (2#)\nLittle Stick ($2)\n\n"}
      assert_response :ok
      assert_equal "Unable to convert into equipment types: Errors exist.", flash[:notice]
      assert_select "li.mass_entry_error", /Equipment category can't be blank/
    end
  end

  test "should create equipment_type" do
    name = @equipment_type.name + " Too"
    assert_difference('EquipmentType.count') do
      post :create, params: { equipment_type: { base_cost: @equipment_type.base_cost,
                                      base_weight: @equipment_type.base_weight,
                                      equipment_category_name: @equipment_type.equipment_category_name,
                                      name: name, notes: @equipment_type.notes,
                                      random_weight: @equipment_type.random_weight} }
      assert_response :found
    end
    equipment_type = EquipmentType.where(:name => name ).order("created_at desc").first
    assert_not_nil equipment_type
    assert_redirected_to equipment_type
    assert_equal equipment_type.equipment_category, equipment_type.equipment_category
    assert_equal equipment_type.base_cost, equipment_type.base_cost
  end
end
