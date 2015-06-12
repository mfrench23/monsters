class ParryScore < AbstractEntity
  belongs_to :creature, touch: true
  validates :parry, presence: true

  def deep_copy
    copy = dup
    copy
  end
end
