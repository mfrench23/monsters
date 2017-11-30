require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = FactoryBot.create(:book)
  end

  test "should get index" do
    get :index
    assert_response :ok
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do
    @unsaved_book = Book.new(name: "War & Peace", abbreviation: "W&P")
    assert_difference('Book.count') do
      post :create, params: { book: { abbreviation: @unsaved_book.abbreviation, name: @unsaved_book.name } }
    end

    assert_response :found
    book = Book.where(:name => @unsaved_book.name ).order("created_at desc").first
    assert_not_nil book
    assert_redirected_to book
  end


  test "should fail to create book" do
    assert_no_difference('Book.count') do
      post :create, params: { book: { abbreviation: @book.abbreviation, name: nil } }
    end

    assert_response 200
  end

  test "should show book" do
    get :show, params: { id: @book }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @book }
    assert_response :success
  end

  test "should update book" do
    patch :update, params: { id: @book, book: { abbreviation: @book.abbreviation, name: @book.name } }
    assert_redirected_to @book
  end

  test "should fail to update book" do
    patch :update, params: { id: @book, book: { abbreviation: @book.abbreviation, name: nil } }
    assert_response 200
  end

  test "should destroy book" do
    @request.env['HTTP_REFERER'] = books_path
    assert_difference('Book.count', -1) do
      delete :destroy, params: { id: @book }
    end

    assert_redirected_to books_path
  end
end
