class MovementRate < AbstractEntity
  belongs_to :monster, touch: true
  belongs_to :move_type
  delegate :name, to: :move_type, prefix: true, allow_nil: true

  def deep_copy
    copy = dup
    copy
  end
end
