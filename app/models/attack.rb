class Attack < AbstractEntity
  belongs_to :monster, touch: true

  def deep_copy
    copy = dup
    copy
  end
end
