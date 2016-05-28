# The GURPS DR covering a particular location
class DamageResistance < AbstractEntity
  belongs_to :creature, touch: true
  belongs_to :location

  def deep_copy
    copy = dup
    copy
  end
end
