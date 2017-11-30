require 'test_helper'

class CreatureFormTest < ActionView::TestCase
  setup do
    dx = Characteristic.find_by(:name => "DX" )
    iq = Characteristic.find_by(:name => "IQ" )
    params = ActionController::Parameters.new(
      {:creature =>
       {:bogusValue => "Bogus",
        :name => "Bob",
        :characteristic_monsters_attributes => { "0" => {:characteristic_id => dx.id.to_s, :score => "11"},
                                                 "1" => {:characteristic_id => iq.id.to_s, :score => "12"} },
        :freeform_skill_list => "Stealth-14; Brawling@DX+1"
       }
      })
    @form = CreatureForm.new(params)
  end

  test "should filter unwanted fields" do
    assert_equal "Bob", @form.params[:name]
    assert_nil @form.params[:bogusValue]
  end

  test "should convert freeform skills parameters" do
    assert_equal true, @form.params[:freeform_skill_list].blank?
    assert_not_nil @form.params[:skills_attributes]
    assert_equal 2, @form.params[:skills_attributes].keys.count
    stealth_array = @form.params[:skills_attributes]["0"]
    brawling_array = @form.params[:skills_attributes]["1"]
    assert_equal "Brawling", MasterSkill.find(brawling_array[:master_skill_id]).name
    assert_equal "Stealth", MasterSkill.find(stealth_array[:master_skill_id]).name
    assert_equal "1", brawling_array[:modifier].to_s
    assert_equal "3", stealth_array[:modifier].to_s
  end
end