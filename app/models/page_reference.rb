# One or more pages in a given Book
class PageReference < AbstractEntity
  belongs_to :book
  belongs_to :referenceable, polymorphic: true, touch: true

  def to_s
    if not pages.blank?
      pg = "p. " + pages
    end
    ( book.try(:to_reference_s).to_s + " " + pg.to_s ).strip
  end

  def deep_copy
    copy = dup
    copy
  end
end
