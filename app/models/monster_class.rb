class MonsterClass < AbstractEntity
  has_many :monsters, dependent: :destroy

  validates :name, presence: true
end
