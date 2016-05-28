# One rate of movement in a particular mode (ie, flying, walking, etc) for a given Monster
class MovementRate < AbstractEntity
  belongs_to :monster, touch: true
  belongs_to :move_type
  delegate :name, to: :move_type, prefix: true, allow_nil: true

  def deep_copy
    copy = dup
    copy
  end
end
