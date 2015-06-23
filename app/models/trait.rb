class Trait < AbstractEntity
  belongs_to :trait_owner, polymorphic: true, touch: true
  belongs_to :master_trait

  validates :master_trait, presence: true

  delegate :name, to: :trait_owner, prefix: true
  delegate :name, to: :master_trait, prefix: true
  delegate :notes, to: :master_trait, prefix: true

  scope :creature_owned, -> { where('trait_owner_type = ?', "Creature") }
  scope :meta_trait_owned, -> { where('trait_owner_type = ?', "MasterTrait") }

  def deep_copy
    copy = dup
    copy
  end

  private
end
