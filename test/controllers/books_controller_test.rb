require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = FactoryGirl.create(:book)
    @unsaved_book = FactoryGirl.build(:book, name: "War & Peace", abbreviation: "W&P")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, book: { abbreviation: @unsaved_book.abbreviation, name: @unsaved_book.name }
    end

    assert_redirected_to book_path(assigns(:book))
  end


  test "should fail to create book" do
    assert_no_difference('Book.count') do
      post :create, book: { abbreviation: @book.abbreviation, name: nil }
    end

    assert_response 200
  end

  test "should show book" do
    get :show, id: @book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book
    assert_response :success
  end

  test "should update book" do
    patch :update, id: @book, book: { abbreviation: @book.abbreviation, name: @book.name }
    assert_redirected_to book_path(assigns(:book))
  end

  test "should fail to update book" do
    patch :update, id: @book, book: { abbreviation: @book.abbreviation, name: nil }
    assert_response 200
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @book
    end

    assert_redirected_to books_path
  end
end
