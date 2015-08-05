require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  setup do
    @monster = FactoryGirl.create(:monster)
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
