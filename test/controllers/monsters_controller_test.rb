require 'test_helper'

class MonstersControllerTest < ActionController::TestCase
  setup do
    @monster = FactoryGirl.create(:monster)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monsters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monster" do
    assert_difference('Monster.count') do
      post :create, monster: { block: @monster.block, description: @monster.description, 
                               dodge: @monster.dodge, gear: @monster.gear, height: @monster.height, 
                               monster_class_id: @monster.monster_class_id, name: @monster.name, 
                               notes: @monster.notes, speed: @monster.speed, weight: @monster.weight,
                               characteristic_monsters: @monster.characteristic_monsters }
    end

    assert_redirected_to monster_path(assigns(:monster))
  end

  test "should fail to create monster" do
    assert_no_difference('Monster.count') do
      post :create, monster: { block: @monster.block }
    end

    assert_response 200
  end

  test "should show monster" do
    get :show, id: @monster
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @monster
    assert_response :success
  end

  test "should update monster" do
    patch :update, id: @monster, monster: { block: @monster.block, description: @monster.description, dodge: @monster.dodge, gear: @monster.gear, height: @monster.height, notes: @monster.notes, speed: @monster.speed, weight: @monster.weight }
    assert_redirected_to monster_path(assigns(:monster))
  end

  test "should fail to update monster" do
    patch :update, id: @monster, monster: { name: nil }
    assert_response 200
  end

  test "should destroy monster" do
    assert_difference('Monster.count', -1) do
      delete :destroy, id: @monster
    end

    assert_redirected_to monsters_path
  end
end
