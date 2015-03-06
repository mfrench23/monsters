require 'test_helper'

class MonsterClassesControllerTest < ActionController::TestCase
  setup do
    @monster_class = monster_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monster_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monster_class" do
    assert_difference('MonsterClass.count') do
      post :create, monster_class: { name: @monster_class.name }
    end

    assert_redirected_to monster_class_path(assigns(:monster_class))
  end

  test "should show monster_class" do
    get :show, id: @monster_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @monster_class
    assert_response :success
  end

  test "should update monster_class" do
    patch :update, id: @monster_class, monster_class: { name: @monster_class.name }
    assert_redirected_to monster_class_path(assigns(:monster_class))
  end

  test "should destroy monster_class" do
    assert_difference('MonsterClass.count', -1) do
      delete :destroy, id: @monster_class
    end

    assert_redirected_to monster_classes_path
  end
end
