require 'test_helper'

class DamageResistancesControllerTest < ActionController::TestCase
  setup do
    @damage_resistance = damage_resistances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:damage_resistances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create damage_resistance" do
    assert_difference('DamageResistance.count') do
      post :create, damage_resistance: { dr: @damage_resistance.dr, location_id: @damage_resistance.location_id, monster_id: @damage_resistance.monster_id, notes: @damage_resistance.notes }
    end

    assert_redirected_to damage_resistance_path(assigns(:damage_resistance))
  end

  test "should show damage_resistance" do
    get :show, id: @damage_resistance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @damage_resistance
    assert_response :success
  end

  test "should update damage_resistance" do
    patch :update, id: @damage_resistance, damage_resistance: { dr: @damage_resistance.dr, location_id: @damage_resistance.location_id, monster_id: @damage_resistance.monster_id, notes: @damage_resistance.notes }
    assert_redirected_to damage_resistance_path(assigns(:damage_resistance))
  end

  test "should destroy damage_resistance" do
    assert_difference('DamageResistance.count', -1) do
      delete :destroy, id: @damage_resistance
    end

    assert_redirected_to damage_resistances_path
  end
end
