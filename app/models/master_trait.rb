class MasterTrait < AbstractEntity
  has_many :traits
  accepts_nested_attributes_for :traits, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  before_validation :nil_blank_attributes

  # Given another MasterTrait, take over the traits it is responsible for, and delete it.
  def merge(dupe)
    dupe.traits.update_all(master_trait_id: self.id)
    dupe.destroy
  end

  private

  def nil_blank_attributes
    [:name, :notes].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end
end
