class MonsterClass < AbstractEntity
  include Nameable

  has_many :monsters, dependent: :destroy
end
