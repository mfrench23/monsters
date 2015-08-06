class Book < AbstractEntity
  include Filterable
  include Nameable

  has_many :page_references, dependent: :destroy
  has_many :monsters, through: :page_references, :source => :referenceable, :source_type => Monster.to_s

  def to_reference_s
    abbreviation.blank? ? name : abbreviation
  end
end
