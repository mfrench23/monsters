# A mode of movement, like "flying" or "swimming"
class MoveType < AbstractEntity
  include UniquelyNameable

  has_many  :movement_rates, dependent: :destroy
end
