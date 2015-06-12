require 'test_helper'

class MonstersControllerTest < ActionController::TestCase
  setup do
    @monster = FactoryGirl.create(:creature)
  end

  test "should get index" do
    get :index
    assert_response :ok
    assert_select "table tbody tr", 1 # expect just one row in the body of the table
    assert_select "table tbody tr td a", @monster.name
  end
end
