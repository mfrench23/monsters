require 'test_helper'

class CreaturesControllerTest < ActionController::TestCase
  setup do
    @creature = FactoryBot.build(:creature)
    cookies[:selected_campaign] = @creature.campaign_id.to_s

    @creature.monster_names << MonsterName.new(:name => "Timmy")
    @creature.traits << FactoryBot.build(:trait)
    @creature.save
  end

  test "index should redirect to monsters controller" do
    get :index
    assert_redirected_to monsters_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create creature" do
    name = @creature.name + " Creation!"
    assert_difference(['Monster.count', 'Creature.count']) do
      post :create, params: { creature: { description: @creature.description, height: @creature.height, 
                               monster_class_id: @creature.monster_class_id, name: name, 
                               notes: @creature.notes, weight: @creature.weight,
                               characteristic_monsters: @creature.characteristic_monsters } }
    end

    assert_response :found
    creature = Creature.where(:name => name ).order("monsters.created_at desc").first
    assert_not_nil creature
    assert_redirected_to creature
  end

  test "should fail to create creature" do
    assert_no_difference(['Monster.count', 'Creature.count']) do
      post :create, params: { creature: { name: nil } }
    end

    assert_response 200
  end

  test "should show creature" do
    get :show, params: { id: @creature }
    assert_response :success
  end

  test "should get variant page" do
    get :variant, params: { id: @creature }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @creature }
    assert_response :success
  end

  test "should update creature" do
    patch :update, params: { id: @creature, creature: { description: "Updated description" } }
    assert_redirected_to @creature
  end

  test "should fail to update creature" do
    patch :update, params: { id: @creature, creature: { name: nil } }
    assert_response 200
  end

  test "should destroy creature" do
    @request.env['HTTP_REFERER'] = creatures_path
    assert_difference('Monster.count', -1) do
      delete :destroy, id: @creature
    end

    assert_redirected_to creatures_path
  end
end
