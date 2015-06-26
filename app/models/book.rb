class Book < AbstractEntity
  has_many :page_references, dependent: :destroy
  has_many :monsters, through: :page_references

  validates :name, presence: true

  scope :order_by_name, -> { order(:name) }

  def to_reference_s
    abbreviation.blank? ? name : abbreviation
  end
end
