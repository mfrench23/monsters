require 'test_helper'

class CreaturesControllerTest < ActionController::TestCase
  setup do
    @creature = FactoryGirl.build(:creature)
    @creature.monster_names << FactoryGirl.build(:monster_name)
    @creature.save
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create creature" do
    name = @creature.name + " Creation!"
    assert_difference(['Monster.count', 'Creature.count']) do
      post :create, creature: { description: @creature.description, height: @creature.height, 
                               monster_class_id: @creature.monster_class_id, name: name, 
                               notes: @creature.notes, weight: @creature.weight,
                               characteristic_monsters: @creature.characteristic_monsters }
    end

    assert_response :found
    creature = Creature.where(:name => name ).order("monsters.created_at desc").first
    assert_not_nil creature
    assert_redirected_to creature
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

  test "should get variant page" do
    get :variant, id: @creature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @creature
    assert_response :success
  end

  test "should update creature" do
    patch :update, id: @creature, creature: { description: "Updated description" }
    assert_redirected_to @creature
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
