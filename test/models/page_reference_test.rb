require 'test_helper'

class PageReferenceTest < ActiveSupport::TestCase
  test "to_s" do
    assert_equal "Some Random Book", PageReference.new(:book => Book.new(:name => "Some Random Book")).to_s
    assert_equal "NPt p. 23-4", PageReference.new(:pages => "23-4", :book => Book.new(name: "No Point?", abbreviation: "NPt")).to_s
    assert_equal "p. 23-4", PageReference.new(:pages => "23-4").to_s
  end
end
