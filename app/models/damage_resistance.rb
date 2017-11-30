# The GURPS DR covering a particular location
class DamageResistance < AbstractEntity
  belongs_to :monster, touch: true
  belongs_to :location

  def deep_copy
    copy = dup
    copy
  end
end
