require 'test_helper'

<% module_namespacing do -%>
class <%= controller_class_name %>ControllerTest < ActionController::TestCase
  setup do
    @campaign = FactoryGirl.create(:campaign)
    cookies[:selected_campaign] = @campaign.id.to_s
    @<%= singular_table_name %> = FactoryGirl.create(:<%= singular_table_name %>)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "table tbody tr" # expect at least one row in the body of the table
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create <%= singular_table_name %>" do
    assert_difference('<%= class_name %>.count') do
      post :create, <%= "#{singular_table_name}: { #{attributes_hash} }" %>
    end

    assert_response :found
    <%= singular_table_name %> = <%= singular_table_name.classify %>.order("created_at desc").first
    assert_not_nil <%= singular_table_name %>
    assert_redirected_to <%= singular_table_name %>
  end

  test "should show <%= singular_table_name %>" do
    get :show, id: <%= "@#{singular_table_name}" %>
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: <%= "@#{singular_table_name}" %>
    assert_response :success
  end

  test "should update <%= singular_table_name %>" do
    patch :update, id: <%= "@#{singular_table_name}" %>, <%= "#{singular_table_name}: { #{attributes_hash} }" %>
    assert_redirected_to @<%= singular_table_name %>
  end

  test "should destroy <%= singular_table_name %>" do
    @request.env['HTTP_REFERER'] = <%= singular_table_name.pluralize %>_path
    assert_difference('<%= class_name %>.count', -1) do
      delete :destroy, id: <%= "@#{singular_table_name}" %>
    end
    assert_redirected_to <%= index_helper %>_path
  end
end
<% end -%>
