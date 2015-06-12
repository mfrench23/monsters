class MoveType < AbstractEntity
  has_many  :movement_rates, dependent: :destroy

  validates :name, presence: true
end
