require 'test_helper'

class MoveTypesControllerTest < ActionController::TestCase
  setup do
    @move_type = MoveType.find_by(name: "ground")
  end

  test "should get index" do
    get :index
    assert_response :ok
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create move_type" do
    name = "crawling diagonally"
    assert_difference('MoveType.count') do
      post :create, move_type: { name: name }
    end

    assert_response :found
    move_type = MoveType.where(:name => name ).order("created_at desc").first
    assert_not_nil move_type
    assert_redirected_to move_type
  end

  test "should fail to create move_type" do
    assert_no_difference('MoveType.count') do
      post :create, move_type: { name: nil }
    end

    assert_response 200
  end

  test "should show move_type" do
    get :show, id: @move_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @move_type
    assert_response :success
  end

  test "should update move_type" do
    patch :update, id: @move_type, move_type: { name: @move_type.name }
    assert_redirected_to @move_type
  end

  test "should fail to update move_type" do
    patch :update, id: @move_type, move_type: { name: nil }
    assert_response 200
  end

  test "should destroy move_type" do
    assert_difference('MoveType.count', -1) do
      delete :destroy, id: @move_type
    end

    assert_redirected_to move_types_path
  end
end
