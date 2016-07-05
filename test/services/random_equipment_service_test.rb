require 'test_helper'

class RandomEquipmentServiceTest < ActionController::TestCase
  setup do
    @equipment_category = FactoryGirl.create(:equipment_category)
    @campaign = @equipment_category.campaign
    @equipment_type = EquipmentType.new(:name => "Fern",
                                        :base_cost_cents => 1000,
                                        :base_weight => 1,
                                        :equipment_category => @equipment_category,
                                        :campaign => @campaign)
    @equipment_type.save!
    @equipment_modifier_supercategory = EquipmentModifierSupercategory.new(:name => "Decorations")
    @equipment_modifier_supercategory.save!
    @equipment_modifier_category = EquipmentModifierCategory.new(:name => "Portlandian",
                                                                 :equipment_modifier_supercategory => @equipment_modifier_supercategory)
    @equipment_modifier_category.save!
    @equipment_modifier = EquipmentModifier.new(:name => "A bird put on it",
                                                :cost_mod => "+1CF", :weight_mod => "x3",
                                                :equipment_modifier_category => @equipment_modifier_category)
    @equipment_modifier.save!
    @random_eq_profile = RandomEqProfile.new(:equipment_category => @equipment_category)
    @random_eq_line_item = RandomEqProfileLineItem.new(:quantity => 1, :equipment_modifier_supercategory => @equipment_modifier_supercategory )
    @random_eq_profile.random_eq_profile_line_items << @random_eq_line_item
    @random_eq_profile.save!
    @service = RandomEquipmentService.new
    @controller = CampaignsController.new
    cookies[:selected_campaign] = @campaign.id.to_s
  end

  test "should return a random piece of equipment if given useful input - whole campaign" do
    result = @service.randomize(@campaign)
    check_standard_expectations(result)
  end

  test "should return a random piece of equipment if given useful input - equipment_category" do
    result = @service.randomize(@equipment_category)
    check_standard_expectations(result)
  end

  test "should return a random piece of equipment if given useful input - random_eq_profile" do
    result = @service.randomize(@random_eq_profile)
    check_standard_expectations(result)
  end

  def check_standard_expectations(result)
    result.save!
    assert_equal 2000, result.total_cost_cents
    assert_equal 3.0, result.total_weight
  end

  test "should respect modifier exclusions" do
    # modify the data
    @random_eq_line_item.quantity = 2
    @random_eq_line_item.save!
    equipment_modifier2 = EquipmentModifier.new(:name => "A different bird put on it",
                                                :cost_mod => "+1CF", :weight_mod => "x3",
                                                :equipment_modifier_category => @equipment_modifier_category)
    equipment_modifier2.excluded_equipment_modifiers << @equipment_modifier
    equipment_modifier2.save!
    # get random result
    result = @service.randomize(@campaign)
    assert_equal true, result.respond_to?(:total_cost)
    assert_equal true, result.respond_to?(:total_weight)
    # will get same results no matter which modifier is chosen
    result.save!
    assert_equal 2000, result.total_cost_cents
    assert_equal 3.0, result.total_weight
  end

  test "should get randomized equipment" do
    @request.env['HTTP_REFERER'] = "localhost"
    assert_difference('EquipmentPackage.count') do
      get :randomize
    end
    equipment_package = EquipmentPackage.order("created_at desc").first
    assert_not_nil equipment_package
    assert_redirected_to equipment_package
  end
end
