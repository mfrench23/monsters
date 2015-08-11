class Book < AbstractEntity
  include Nameable

  has_many :page_references, dependent: :destroy

  def to_reference_s
    abbreviation.blank? ? name : abbreviation
  end
end
