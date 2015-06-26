class MoveType < AbstractEntity
  has_many  :movement_rates, dependent: :destroy

  validates :name, presence: true

  scope :order_by_name, -> { order(:name) }
end
