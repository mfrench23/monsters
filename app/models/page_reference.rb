class PageReference < AbstractEntity
  belongs_to :book
  belongs_to :referenceable, polymorphic: true, touch: true

  def to_s
    if not pages.blank?
      pg = "p. " + pages
    end
    ( book.nil? ? pg.to_s : book.to_reference_s + " #{pg}" ).strip
  end

  def deep_copy
    copy = dup
    copy
  end
end
