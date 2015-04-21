require 'test_helper'

class MoveTypesControllerTest < ActionController::TestCase
  setup do
    @move_type = FactoryGirl.create(:move_type)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:move_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create move_type" do
    assert_difference('MoveType.count') do
      post :create, move_type: { name: @move_type.name }
    end

    assert_redirected_to move_type_path(assigns(:move_type))
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
    assert_redirected_to move_type_path(assigns(:move_type))
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
