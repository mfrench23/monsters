# Represents a book or other source of GURPS-related information
class Book < AbstractEntity
  include UniquelyNameable

  has_many :page_references, dependent: :destroy

  def page_references_by_type
    page_references.group_by{ |p| p.referenceable_type }
  end

  def to_reference_s
    abbreviation.blank? ? name : abbreviation
  end
end
