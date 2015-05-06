require 'test_helper'

class PageReferenceTest < ActiveSupport::TestCase
  setup do
    @one = FactoryGirl.create(:page_reference)

    @book = FactoryGirl.create(:book, name: "No Point?", abbreviation: "NPt")
    @two = FactoryGirl.create(:page_reference, book: @book, pages: "23-4")
    @three = FactoryGirl.create(:page_reference, book: nil, pages: "23-4")
    
    @bookNameOnly = FactoryGirl.create(:book, name: "Some Other Book", abbreviation: "")
    @four = FactoryGirl.create(:page_reference, book: @bookNameOnly, pages: nil)
  end

  test "to_s" do
    assert_equal "Some Random Book", @one.to_s
    assert_equal "NPt p. 23-4", @two.to_s
    assert_equal "p. 23-4", @three.to_s
    assert_equal "Some Other Book", @four.to_s
  end
end
