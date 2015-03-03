require 'test_helper'

class MovementRatesControllerTest < ActionController::TestCase
  setup do
    @movement_rate = movement_rates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movement_rates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movement_rate" do
    assert_difference('MovementRate.count') do
      post :create, movement_rate: { monster_id: @movement_rate.monster_id, rate: @movement_rate.rate, terrain_type_id: @movement_rate.terrain_type_id }
    end

    assert_redirected_to movement_rate_path(assigns(:movement_rate))
  end

  test "should show movement_rate" do
    get :show, id: @movement_rate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movement_rate
    assert_response :success
  end

  test "should update movement_rate" do
    patch :update, id: @movement_rate, movement_rate: { monster_id: @movement_rate.monster_id, rate: @movement_rate.rate, terrain_type_id: @movement_rate.terrain_type_id }
    assert_redirected_to movement_rate_path(assigns(:movement_rate))
  end

  test "should destroy movement_rate" do
    assert_difference('MovementRate.count', -1) do
      delete :destroy, id: @movement_rate
    end

    assert_redirected_to movement_rates_path
  end
end
