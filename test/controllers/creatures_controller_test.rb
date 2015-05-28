require 'test_helper'

class CreaturesControllerTest < ActionController::TestCase
  setup do
    @creature = FactoryGirl.create(:creature)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create creature" do
    assert_difference(['Monster.count', 'Creature.count']) do
      post :create, creature: { description: @creature.description, height: @creature.height, 
                               monster_class_id: @creature.monster_class_id, name: @creature.name, 
                               notes: @creature.notes, weight: @creature.weight,
                               characteristic_monsters: @creature.characteristic_monsters }
    end

    assert_redirected_to creature_path(assigns(:creature))
  end

  test "should fail to create creature" do
    assert_no_difference(['Monster.count', 'Creature.count']) do
      post :create, creature: { name: nil }
    end

    assert_response 200
  end

  test "should show creature" do
    get :show, id: @creature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @creature
    assert_response :success
  end

  test "should update creature" do
    patch :update, id: @creature, creature: { description: "Updated description" }
    assert_redirected_to creature_path(assigns(:creature))
  end

  test "should fail to update creature" do
    patch :update, id: @creature, creature: { name: nil }
    assert_response 200
  end

  test "should destroy creature" do
    assert_difference(['Monster.count', 'Creature.count'], -1) do
      delete :destroy, id: @creature
    end

    assert_redirected_to monsters_path
  end
end
