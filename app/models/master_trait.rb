class MasterTrait < AbstractEntity
  has_many :traits
  accepts_nested_attributes_for :traits, allow_destroy: true, :reject_if => lambda { |x| x['creature'].blank? }

  has_many :traits_in_meta_trait, :class_name => 'Trait', :foreign_key => "meta_trait_id"
  accepts_nested_attributes_for :traits_in_meta_trait, allow_destroy: true, :reject_if => lambda { |x| x['master_trait_id'].blank? }

  validates :name, presence: true
  before_validation :nil_blank_attributes

  # Given another MasterTrait, take over the traits it is responsible for, and delete it.
  def merge(dupe)
    dupe.traits.update_all(master_trait_id: self.id)
    dupe.destroy
  end

  def meta_trait?
    traits_in_meta_trait.any?
  end

  private

  def nil_blank_attributes
    [:name, :notes].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end
end
