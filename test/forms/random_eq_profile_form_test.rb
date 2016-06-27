require 'test_helper'

class RandomEqProfileFormTest < ActionView::TestCase
  setup do
    supercat = FactoryGirl.create(:equipment_modifier_supercategory)
    params = ActionController::Parameters.new(
      {:random_eq_profile =>
       {:bogusValue => "Bogus",
        :random_weight => 1,
        :random_eq_profile_line_items_attributes => 
          { "0" => {:quantity => 2, :equipment_modifier_supercategory_id => supercat.id} }
       }
      })
    @form = RandomEqProfileForm.new(params)
  end

  test "should filter unwanted fields" do
    assert_nil @form.params[:bogusValue]
    entity = RandomEqProfile.new(@form.params)
    entity.save!
    assert_equal 1, entity.random_eq_profile_line_items.count
  end
end