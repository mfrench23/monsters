require 'test_helper'

class MasterTraitsControllerTest < ActionController::TestCase
  setup do
    @master_trait = FactoryGirl.create(:master_trait)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:master_traits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create master_trait" do
    assert_difference('MasterTrait.count') do
      post :create, master_trait: { is_feature: @master_trait.is_feature, name: @master_trait.name, notes: @master_trait.notes }
    end

    assert_redirected_to master_trait_path(assigns(:master_trait))
  end

  test "should fail to create master_trait" do
    assert_no_difference('MasterTrait.count') do
      post :create, master_trait: { is_feature: @master_trait.is_feature, name: nil, notes: @master_trait.notes }
    end

    assert_response :success
  end

  test "should show master_trait" do
    get :show, id: @master_trait
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @master_trait
    assert_response :success
  end

  test "should get merge" do
    get :merge_into, id: @master_trait
    assert_response :success
  end

  test "should merge duplicate into master_trait" do
    dupe = FactoryGirl.create(:master_trait, name: 'Copy of ' + @master_trait.name)
    assert_difference('MasterTrait.count', -1) do
      post :merge_into, { merge_into_trait_id: @master_trait.id, id: dupe.id }
    end

    assert_redirected_to master_trait_path(@master_trait)
  end

  test "should update master_trait" do
    patch :update, id: @master_trait, master_trait: { is_feature: @master_trait.is_feature, name: @master_trait.name, notes: @master_trait.notes }
    assert_redirected_to master_trait_path(assigns(:master_trait))
  end

  test "should fail to update master_trait" do
    patch :update, id: @master_trait, master_trait: { name: nil }
    assert_response 200
  end

  test "should destroy master_trait" do
    assert_difference('MasterTrait.count', -1) do
      delete :destroy, id: @master_trait
    end

    assert_redirected_to master_traits_path
  end
end
