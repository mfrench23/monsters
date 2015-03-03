require 'test_helper'

class ParryScoresControllerTest < ActionController::TestCase
  setup do
    @parry_score = parry_scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parry_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parry_score" do
    assert_difference('ParryScore.count') do
      post :create, parry_score: { parry: @parry_score.parry, weapon: @parry_score.weapon }
    end

    assert_redirected_to parry_score_path(assigns(:parry_score))
  end

  test "should show parry_score" do
    get :show, id: @parry_score
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parry_score
    assert_response :success
  end

  test "should update parry_score" do
    patch :update, id: @parry_score, parry_score: { parry: @parry_score.parry, weapon: @parry_score.weapon }
    assert_redirected_to parry_score_path(assigns(:parry_score))
  end

  test "should destroy parry_score" do
    assert_difference('ParryScore.count', -1) do
      delete :destroy, id: @parry_score
    end

    assert_redirected_to parry_scores_path
  end
end
