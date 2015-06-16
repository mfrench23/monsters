class Trait < AbstractEntity
  belongs_to :creature, touch: true
  belongs_to :master_trait

  has_one :monster, :through => :creature

  validates :master_trait, presence: true

  delegate :name, to: :monster, prefix: true
  delegate :name, to: :master_trait, prefix: true

  def deep_copy
    copy = dup
    copy
  end
end
