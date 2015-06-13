require 'test_helper'

class SortableHelperTest < ActionView::TestCase
  test "OK to sort monsters by name" do
    assert_equal true, is_acceptable_sort_column(Monster, "monsters.name")
  end

  test "not OK to sort monsters by a fake column name" do
    assert_equal false, is_acceptable_sort_column(Monster, "monsters.crap_field_name")
  end

  test "not OK to sort monsters with a bad table name" do
    assert_equal false, is_acceptable_sort_column(Monster, "monsterz.name")
  end

  test "OK to sort master traits by name and notes" do
    assert_equal true, is_acceptable_sort_column(MasterTrait, "master_traits.name, master_traits.notes")
  end

  test "sort_param" do
    assert_equal "monsters.name asc", sort_param(Monster, "monsters.name", "asc")
    assert_equal "master_traits.name desc, master_traits.notes desc", sort_param(MasterTrait, "master_traits.name, master_traits.notes", "desc")
  end
end