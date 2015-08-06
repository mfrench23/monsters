require 'test_helper'

class AncestorTreeHelperTest < ActionView::TestCase
  test "should build a tree with parents and alphabetized children" do
    mc = MonsterClass.first
    monster_a = Swarm.new(:name => "AAA", :monster_class => mc)
    assert_equal true, monster_a.save
    monster_b = Swarm.new(:name => "BBB", :parent => monster_a, :monster_class => mc)
    assert_equal true, monster_b.save
    monster_bz = Swarm.new(:name => "BBBZ", :parent => monster_b, :monster_class => mc )
    assert_equal true, monster_bz.save
    monster_bm = Swarm.new(:name => "BBBM", :parent => monster_b, :monster_class => mc )
    assert_equal true, monster_bm.save
    monster_ba = Swarm.new(:name => "BBBA", :parent => monster_b, :monster_class => mc )
    assert_equal true, monster_ba.save

    result = ancestor_tree(monster_b)
    a = /.*?/ # skip on a bit
    match = result.match /(AAA)#{a}ancestor#{a}BBB#{a}BBBA#{a}descendant#{a}BBBM#{a}descendant#{a}(BBBZ)#{a}descendant/
    assert_equal "AAA", match[1]
    assert_equal "BBBZ", match[2]
  end
end