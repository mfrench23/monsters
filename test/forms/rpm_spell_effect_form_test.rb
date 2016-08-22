require 'test_helper'

class RpmSpellEffectFormTest < ActionView::TestCase
  setup do
    params = ActionController::Parameters.new(
      {:rpm_spell_effect =>
       {:bogusValue => "Bogus",
        :rpm_potency_id => 1
       }
      })
    @form =RpmSpellEffectForm.new(params)
  end

  test "should filter unwanted fields" do
    assert_nil @form.params[:bogusValue]
    assert_equal 1, @form.params[:rpm_potency_id]
  end
end