require 'test_helper'

class CreatureFormTest < ActionView::TestCase
  setup do
    params = ActionController::Parameters.new(
      {:creature =>
       {:bogusValue => "Bogus",
        :name => "Bob"
       }
      })
    @form = CreatureForm.new(params)
  end

  test "should filter unwanted fields" do
    assert_equal "Bob", @form.params[:name]
    assert_nil @form.params[:bogusValue]
  end
end