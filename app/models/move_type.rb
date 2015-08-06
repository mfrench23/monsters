class MoveType < AbstractEntity
  include Nameable

  has_many  :movement_rates, dependent: :destroy
end
