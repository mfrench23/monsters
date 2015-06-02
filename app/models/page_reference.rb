class PageReference < ActiveRecord::Base
  belongs_to :book
  belongs_to :monster

  def to_s
    if not pages.nil?
      pg = "p. " + pages
    end
    ( book.nil? ? pg : book.to_reference_s + " #{pg}" ).strip
  end

  def deep_copy
    copy = dup
    copy
  end
end
