class Trait < AbstractEntity
  belongs_to :creature, touch: true
  belongs_to :master_trait

  validates :master_trait, presence: true

  def deep_copy
    copy = dup
    copy
  end
end
