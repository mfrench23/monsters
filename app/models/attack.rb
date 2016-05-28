# A single attack of possibly several that a given monster might possess
class Attack < AbstractEntity
  belongs_to :monster, touch: true

  def deep_copy
    copy = dup
    copy
  end
end
