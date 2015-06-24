class Trait < AbstractEntity
  belongs_to :trait_owner, polymorphic: true, touch: true
  belongs_to :master_trait
  belongs_to :creature

  validates :master_trait, presence: true

  has_ancestry # for showing the chain of grants through meta-traits ("Meta1 grants Meta2 which grants...")
  has_many :traits, as: :trait_owner, dependent: :destroy

  delegate :name, to: :trait_owner, prefix: true
  delegate :name, to: :master_trait, prefix: true
  delegate :name, to: :master_trait, prefix: false
  delegate :notes, to: :master_trait, prefix: true

  scope :creature_owned, -> { where('trait_owner_type = ?', "Creature") } # traits directly owned by a Creature
  scope :meta_trait_owned, -> { where('trait_owner_type = ?', "MasterTrait") }
  scope :creature_possessed, -> { where('creature_id is not null') } # includes traits indirectly granted through a meta-trait
  scope :meta_trait_member, -> { meta_trait_owned.joins("inner join master_traits on traits.trait_owner_id = master_traits.id").order("master_traits.name") }

  scope :order_by_master_trait, -> { includes(:master_trait).order("master_traits.name") }
  scope :order_by_creature, -> { includes(:creature => [ :monster ]).order("monsters.name") }

  after_save :add_granted_traits
  before_destroy :remove_granted_traits
  before_save :remove_granted_traits, :capture_creature_id

  def deep_copy
    copy = dup
    copy
  end

  private

  def remove_granted_traits
    traits.delete_all
  end

  def capture_creature_id
    self['creature_id'] ||= trait_owner_id if trait_owner_type == 'Creature'
  end

  def add_granted_traits
    master_trait.grant_meta_trait_members(self)
  end
end
