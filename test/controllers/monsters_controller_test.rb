require 'test_helper'

class MonstersControllerTest < ActionController::TestCase
  setup do
    @monster = FactoryBot.create(:creature)
    cookies[:selected_campaign] = @monster.campaign_id.to_s
    @other_monster = Creature.new(:name => "Robert", :monster_class => MonsterClass.find_by(:name => "Undead"), 
                                  :campaign_id => @monster.campaign_id)
    @other_monster.monster_names << MonsterName.new(:name => "Bob")
    @other_monster.monster_names << MonsterName.new(:name => "Dick")
    @other_monster.save!
  end

  test "should show associated creature" do
    get :show, params: { id: @monster.specific.monster.id }
    assert_redirected_to @monster.specific
  end

  test "should get index" do
    get :index, params: { sort: "monster_classes.name" }
    assert_response :ok
    assert_select "table tbody tr", 2 # expect a row in the body of the table for each monster
    assert_select "table tbody tr td a", @monster.name
  end

  test "should get index sorted by name descending" do
    get :index, params: { sort: "monsters.name", direction: "desc" }
    assert_response :ok
    assert_select "table tbody tr", 2 # expect a row in the body of the table for each monster
    assert_select "table tbody tr td a", @other_monster.name
  end

  test "should get index ignoring any bogus sorting" do
    get :index, params: { sort: "monster_classes.bad_hacked_param" }
    assert_response :ok
    assert_select "table tbody tr", 2 # expect a row in the body of the table for each monster
    assert_select "table tbody tr td a", @monster.name
  end

  test "should get index ignoring any bogus sorting, even descending" do
    get :index, params: { sort: "monster_classes.bad_hacked_param", direction: "desc" }
    assert_response :ok
    assert_select "table tbody tr", 2 # expect a row in the body of the table for each monster
    assert_select "table tbody tr td a", @monster.name
  end
end
