require 'test_helper'

class EquipmentTypesControllerCreationTest < ActionController::TestCase
  setup do
    @controller = EquipmentTypesController.new
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
    campaign = FactoryGirl.build(:campaign)
    assert_difference('EquipmentType.count', 1) do
      post :do_mass_entry, {:equipment_category_name => "Weapons",
                                         :campaign_id => campaign.id.to_s,
                                         :freeform_text => "\nBig Stick ($5.50; 2.1#)\n\n"}
      assert_response :found
    end
    type = EquipmentType.find_by(:name => "Big Stick")
    assert_equal "5.50", type.base_cost.to_s
    assert_equal "2.1", "%g" % type.base_weight
    assert_equal "Weapons", type.equipment_category_name
    assert_equal true, type.in_campaign?(campaign.id)
  end

  test "should refuse to do mass entry" do
    campaign = FactoryGirl.build(:campaign)
    assert_no_difference('EquipmentType.count') do
      post :do_mass_entry, {:equipment_category_name => "Weapons" + (Time.now.to_f * 1000).to_s,
                                         :campaign_id => campaign.id,
                                         :freeform_text => "Big Stick (2#)\nLittle Stick ($2)\n\n"}
      assert_equal "Unable to convert into equipment types: Errors exist.", flash[:notice]
      assert_response :ok
    end
  end

  test "should create equipment_type" do
    equipment_type = FactoryGirl.build(:equipment_type)
    name = equipment_type.name + " Too"
    assert_difference('EquipmentType.count') do
      post :create, equipment_type: { base_cost: equipment_type.base_cost,
                                      base_weight: equipment_type.base_weight,
                                      equipment_category_name: equipment_type.equipment_category_name,
                                      name: name, notes: equipment_type.notes }
    end

    assert_response :found
    equipment_type = EquipmentType.where(:name => name ).order("created_at desc").first
    assert_not_nil equipment_type
    assert_redirected_to equipment_type
    assert_equal equipment_type.equipment_category, equipment_type.equipment_category
    assert_equal equipment_type.base_cost, equipment_type.base_cost
  end
end
