require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  test "should get monsters_by_class" do
    get :monsters_by_class
    assert_response :success
  end

  test "should get monsters_by_creation_date" do
    get :monsters_by_creation_date
    assert_response :success
  end
end
