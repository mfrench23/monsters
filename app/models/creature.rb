# Represents a Monster that is treated as a single individual
class Creature < AbstractEntity
  include TraitList
  include NilBlankable

  attr_accessor :freeform_trait_list
  attr_accessor :freeform_skill_list

  before_validation :nil_blank_attributes

  has_many  :damage_resistances, dependent: :destroy
  accepts_nested_attributes_for :damage_resistances, allow_destroy: true, reject_if: :all_blank
  has_many :skills, dependent: :destroy
  accepts_nested_attributes_for :skills, allow_destroy: true, reject_if: :all_blank
  has_many :traits, as: :trait_owner, dependent: :destroy
  accepts_nested_attributes_for :traits, allow_destroy: true, reject_if: :all_blank
  has_many :parry_scores, dependent: :destroy
  accepts_nested_attributes_for :parry_scores, allow_destroy: true, reject_if: :all_blank
  has_many :equipment_packages, dependent: :destroy
  accepts_nested_attributes_for :equipment_packages, allow_destroy: true

  has_many :flattened_traits, -> { order_by_master_trait }, :dependent => :destroy, :class_name => "Trait"

  acts_as :monster

  monetize :parts_value_cents, :allow_nil => true, :numericality => { :greater_than_or_equal_to => 0 }

  validates :freeform_skill_list, absence: true

  def deep_copy
    copy = dup
    copy.monster = monster.deep_copy
    reference_list_attributes.each { |reference| deep_copy_reference(reference, copy) }
    copy
  end

  def freeform_trait_list=(value)
    TraitList::FreeformTraitList.new(value).list.each do |trait|
      self.traits << trait
    end
  end

  def to_s
    name
  end

  private

  def reference_list_attributes
    [:damage_resistances, :skills, :traits, :parry_scores, :equipment_packages]
  end

  def blankable_attributes
    [:height, :weight, :parts_value_cents]
  end
end
