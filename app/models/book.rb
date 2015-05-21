class Book < ActiveRecord::Base
  has_many :page_references, dependent: :destroy

  validates :name, presence: true

  def to_reference_s
    abbreviation.to_s.empty? ? name : abbreviation
  end
end
