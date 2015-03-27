require 'test_helper'

class MonsterFormTest < ActionView::TestCase
  setup do
    params = ActionController::Parameters.new(
      {:monster => 
       {:bogusValue => "Bogus", 
        :name => "Bob"
       }
      })
    @form = MonsterForm.new(params)
  end
  
  test "should filter unwanted fields" do
    assert_equal "Bob", @form.params[:name]
    assert_nil @form.params[:bogusValue]
  end
end