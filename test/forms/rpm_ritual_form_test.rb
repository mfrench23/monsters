require 'test_helper'

class RpmRitualFormTest < ActionView::TestCase
  setup do
    lvl1 = RpmModifierLevel.new(:accepts_enhancements => true)
    lvl1.save!
    lvl2 = RpmModifierLevel.new(:accepts_enhancements => false)
    lvl2.save!
    params = ActionController::Parameters.new(
      {:rpm_ritual =>
       {:bogusValue => "Bogus",
        :name => "Lesser Banishing Ritual of Bob",
        :rpm_ritual_modifiers_attributes => { "0" => {:rpm_modifier_level_id => lvl1.id.to_s, :enhancement_percentage => "25", :enhancement_notes => "note!"},
                                              "1" => {:rpm_modifier_level_id => lvl2.id.to_s, :enhancement_percentage => "15", :enhancement_notes => "NOT!"} }
       }
      })
    @form = RpmRitualForm.new(params)
  end

  test "should filter unwanted fields" do
    assert_equal "Lesser Banishing Ritual of Bob", @form.params[:name]
    assert_nil @form.params[:bogusValue]
  end

  test "should remove enhancement fields when unacceptable" do
    assert_not_nil @form.params[:rpm_ritual_modifiers_attributes]["0"][:enhancement_notes]
    assert_not_nil @form.params[:rpm_ritual_modifiers_attributes]["0"][:enhancement_percentage]

    assert_nil @form.params[:rpm_ritual_modifiers_attributes]["1"][:enhancement_notes]
    assert_nil @form.params[:rpm_ritual_modifiers_attributes]["1"][:enhancement_percentage]
  end
end