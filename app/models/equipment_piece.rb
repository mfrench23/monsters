# A particular instance of an EquipmentType, like "Bob's
# broadsword with the gold wire on the hilt" or "the
# enchanted broadsword behind the door in Room #37".
class EquipmentPiece < ActiveRecord::Base
  include Filterable

  belongs_to :equipment_type
  has_one :equipment_category, :through => :equipment_type

  delegate :name, to: :equipment_type, prefix: true
  delegate :name, to: :equipment_category, prefix: true

  scope :created_on, -> (date) { where("date(equipment_pieces.created_at) = ?", "#{date}")}
  scope :updated_on, -> (date) { where("date(equipment_pieces.updated_at) = ?", "#{date}")}
  scope :order_by_name, -> { order(:name) }

  validates :equipment_type, presence: true
end
