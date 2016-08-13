require 'test_helper'

class PageReferencesHelperTest < ActionView::TestCase
  test "should return nothing for nothing" do
    assert_nil page_references_compact(nil)
  end

  test "should format page references" do
    book1 = Book.new(:name => "A Book")
    book2 = Book.new(:name => "B Book")
    obj = RpmPath.new(:name => "Paths")
    obj.page_references << PageReference.new(:book => book1, :pages => "1-2")
    obj.page_references << PageReference.new(:book => book2, :pages => "15-52")
    ref = page_references_compact(obj)
    assert ref =~ /A Book p\. 1-2.*, .*B Book p\. 15-52/
  end
end
