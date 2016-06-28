require 'test_helper'

class SwarmsControllerTest < ActionController::TestCase
 setup do
    @swarm = FactoryGirl.create(:swarm)
    cookies[:selected_campaign] = @swarm.campaign_id.to_s
  end

  test "index should redirect to monsters controller" do
    get :index
    assert_redirected_to monsters_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create swarm" do
    name = "A Highly Unlikely Swarm Name"
    assert_difference(['Monster.count', 'Swarm.count']) do
      post :create, swarm: { description: @swarm.description,
                               monster_class_id: @swarm.monster_class_id, name: name, 
                               notes: @swarm.notes,
                               characteristic_monsters: @swarm.characteristic_monsters }
    end

    assert_response :found # not :created, since we're being redirected to "show"
    swarm = Swarm.where(:name => name ).order("monsters.created_at desc").first
    assert_not_nil swarm
    assert_redirected_to swarm
  end

  test "should fail to create swarm" do
    assert_no_difference(['Monster.count', 'Swarm.count']) do
      post :create, swarm: { name: nil }
    end

    assert_response 200
  end

  test "should show swarm" do
    get :show, id: @swarm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @swarm
    assert_response :success
  end

  test "should get variant page" do
    get :variant, id: @swarm
    assert_response :success
  end

  test "should update swarm" do
    patch :update, id: @swarm, swarm: { description: "Updated description" }
    assert_redirected_to @swarm
  end

  test "should fail to update swarm" do
    patch :update, id: @swarm, swarm: { name: nil }
    assert_response 200
  end

  test "should destroy swarm" do
    @request.env['HTTP_REFERER'] = swarms_path
    assert_difference(['Monster.count', 'Swarm.count'], -1) do
      delete :destroy, id: @swarm
    end

    assert_redirected_to swarms_path
  end
end
