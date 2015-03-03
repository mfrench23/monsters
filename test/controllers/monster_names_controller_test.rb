require 'test_helper'

class MonsterNamesControllerTest < ActionController::TestCase
  setup do
    @monster_name = monster_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monster_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monster_name" do
    assert_difference('MonsterName.count') do
      post :create, monster_name: { monster_id: @monster_name.monster_id, name: @monster_name.name, notes: @monster_name.notes, primary: @monster_name.primary }
    end

    assert_redirected_to monster_name_path(assigns(:monster_name))
  end

  test "should show monster_name" do
    get :show, id: @monster_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @monster_name
    assert_response :success
  end

  test "should update monster_name" do
    patch :update, id: @monster_name, monster_name: { monster_id: @monster_name.monster_id, name: @monster_name.name, notes: @monster_name.notes, primary: @monster_name.primary }
    assert_redirected_to monster_name_path(assigns(:monster_name))
  end

  test "should destroy monster_name" do
    assert_difference('MonsterName.count', -1) do
      delete :destroy, id: @monster_name
    end

    assert_redirected_to monster_names_path
  end
end
