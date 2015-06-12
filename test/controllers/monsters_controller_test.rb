require 'test_helper'

class MonstersControllerTest < ActionController::TestCase
  setup do
    @monster = FactoryGirl.create(:creature)
    @other_monster = FactoryGirl.build(:creature, :name => "Robert" )
    @other_monster.monster_names << FactoryGirl.build(:monster_name)
    @other_monster.monster_names << FactoryGirl.build(:monster_name, :name => "Dick")
    @other_monster.save
  end

  test "should get index" do
    get :index
    assert_response :ok
    assert_select "table tbody tr", 2 # expect a row in the body of the table for each monster
    assert_select "table tbody tr td a", @monster.name
  end
end
