# One value for a GURPS Parry, specific to one attack owned by a given Creature
class ParryScore < AbstractEntity
  belongs_to :creature, touch: true
  validates :parry, presence: true

  def deep_copy
    copy = dup
    copy
  end
end
