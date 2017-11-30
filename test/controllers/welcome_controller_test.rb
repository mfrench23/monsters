require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  setup do
    @monster = FactoryBot.create(:creature)
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
