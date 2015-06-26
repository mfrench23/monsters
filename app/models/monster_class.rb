class MonsterClass < AbstractEntity
  has_many :monsters, dependent: :destroy

  validates :name, presence: true

  scope :order_by_name, -> { order(:name) }
end
