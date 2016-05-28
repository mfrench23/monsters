# A mode of movement, like "flying" or "swimming"
class MoveType < AbstractEntity
  include Nameable

  has_many  :movement_rates, dependent: :destroy
end
