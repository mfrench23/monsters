class MasterTrait < AbstractEntity
  has_many :traits, dependent: :destroy
  accepts_nested_attributes_for :traits, allow_destroy: true

  has_many :traits_in_meta_trait, as: :trait_owner, :class_name => 'Trait', :dependent => :destroy
  accepts_nested_attributes_for :traits_in_meta_trait, allow_destroy: true, :reject_if => lambda { |x| x['master_trait_id'].blank? }

  validates :name, presence: true
  before_validation :nil_blank_attributes
  after_save :update_granted_traits

  scope :order_by_name, -> { order(:name) }

  # Given another MasterTrait, take over the traits it is responsible for, and delete it.
  def merge(dupe)
    dupe.traits.update_all(master_trait_id: self.id)
    dupe.destroy
  end

  def meta_trait?
    traits_in_meta_trait.any?
  end

  def grant_meta_trait_members(trait)
    traits_in_meta_trait.each do |granted|
      new_trait = granted.deep_copy
      new_trait.trait_owner = trait
      new_trait.parent = trait
      new_trait.creature_id = trait.creature_id
      new_trait.save
    end
  end

  private

  def update_granted_traits
    traits(true).each do |trait|
      trait.save # refreshing the list of granted traits
    end
  end

  def nil_blank_attributes
    [:name, :notes].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end
end
