require 'test_helper'

class ManyToManyCheckboxTableSpecificationTest < ActionView::TestCase
  setup do
    Struct.new("M2MOption", :subheader, :name)
    list = []
    list << Struct::M2MOption.new("ZZZ", "Marvel")
    list << Struct::M2MOption.new("AAA", "Zarathustra")
    list << Struct::M2MOption.new("MMM", "Charles")
    list << Struct::M2MOption.new("AAA", "Benjamin")
    list << Struct::M2MOption.new("MMM", "Davis")
    @table_spec = ManyToManyCheckboxTableSpecification.new(:subheader_field => :subheader,
                                                           :available_intersection_list => list)
  end

  test "should get out what you put in" do
    assert_equal :subheader, @table_spec.subheader_field
    assert_equal 0, @table_spec.subheader_counts["MMM"] # no option selected
    assert_equal "AAA", @table_spec.item_hash.keys.sort.first
    assert_equal "Benjamin", @table_spec.item_hash["AAA"].first.name
  end
end
