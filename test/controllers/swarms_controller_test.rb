require 'test_helper'

class SwarmsControllerTest < ActionController::TestCase
 setup do
    @swarm = FactoryGirl.create(:swarm)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create swarm" do
    assert_difference(['Monster.count', 'Swarm.count']) do
      post :create, swarm: { description: @swarm.description,
                               monster_class_id: @swarm.monster_class_id, name: @swarm.name, 
                               notes: @swarm.notes, 
                               characteristic_monsters: @swarm.characteristic_monsters }
    end

    assert_redirected_to swarm_path(assigns(:swarm))
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

  test "should update swarm" do
    patch :update, id: @swarm, swarm: { description: "Updated description" }
    assert_redirected_to swarm_path(assigns(:swarm))
  end

  test "should fail to update swarm" do
    patch :update, id: @swarm, swarm: { name: nil }
    assert_response 200
  end

  test "should destroy swarm" do
    assert_difference(['Monster.count', 'Swarm.count'], -1) do
      delete :destroy, id: @swarm
    end

    assert_redirected_to monsters_path
  end
end
