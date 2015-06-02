require 'test_helper'

class AncestorTreeHelperTest < ActionView::TestCase
  test "should build a tree with parents and alphabetized children" do
    mc = MonsterClass.first
    monster_a = Swarm.new(:name => "A", :monster_class => mc)
    assert_equal true, monster_a.save
    monster_b = Swarm.new(:name => "B", :parent => monster_a, :monster_class => mc)
    assert_equal true, monster_b.save
    monster_bz = Swarm.new(:name => "BZ", :parent => monster_b, :monster_class => mc )
    assert_equal true, monster_bz.save
    monster_bm = Swarm.new(:name => "BM", :parent => monster_b, :monster_class => mc )
    assert_equal true, monster_bm.save
    monster_ba = Swarm.new(:name => "BA", :parent => monster_b, :monster_class => mc )
    assert_equal true, monster_ba.save

    result = ancestor_tree(monster_b)
    a = /.*?/ # skip on a bit
    match = result.match /(A)#{a}ancestor#{a}B#{a}BA#{a}descendant#{a}BM#{a}descendant#{a}(BZ)#{a}descendant/
    assert_equal "A", match[1]
    assert_equal "BZ", match[2]
  end
end