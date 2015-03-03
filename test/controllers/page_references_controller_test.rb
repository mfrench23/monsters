require 'test_helper'

class PageReferencesControllerTest < ActionController::TestCase
  setup do
    @page_reference = page_references(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:page_references)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page_reference" do
    assert_difference('PageReference.count') do
      post :create, page_reference: { book_id: @page_reference.book_id, monster_id: @page_reference.monster_id, pages: @page_reference.pages }
    end

    assert_redirected_to page_reference_path(assigns(:page_reference))
  end

  test "should show page_reference" do
    get :show, id: @page_reference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page_reference
    assert_response :success
  end

  test "should update page_reference" do
    patch :update, id: @page_reference, page_reference: { book_id: @page_reference.book_id, monster_id: @page_reference.monster_id, pages: @page_reference.pages }
    assert_redirected_to page_reference_path(assigns(:page_reference))
  end

  test "should destroy page_reference" do
    assert_difference('PageReference.count', -1) do
      delete :destroy, id: @page_reference
    end

    assert_redirected_to page_references_path
  end
end
