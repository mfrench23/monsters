class Trait < AbstractEntity
  belongs_to :creature, touch: true
  belongs_to :master_trait
  belongs_to :meta_trait, :class_name => 'MasterTrait'

  has_one :monster, :through => :creature

  validates :master_trait, presence: true

  delegate :name, to: :monster, prefix: true, allow_nil: true
  delegate :name, to: :master_trait, prefix: true
  delegate :notes, to: :master_trait, prefix: true

  def deep_copy
    copy = dup
    copy
  end

  private
end
