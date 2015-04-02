class Monster < ActiveRecord::Base
  include TraitList

  has_many :page_references, dependent: :destroy
  accepts_nested_attributes_for :page_references, allow_destroy: true, reject_if: :all_blank
  has_many :skills, dependent: :destroy
  accepts_nested_attributes_for :skills, allow_destroy: true, reject_if: :all_blank
  has_many :traits, dependent: :destroy
  accepts_nested_attributes_for :traits, allow_destroy: true, reject_if: :all_blank
  has_many :attacks, dependent: :destroy
  accepts_nested_attributes_for :attacks, allow_destroy: true, reject_if: :all_blank
  has_many  :damage_resistances, dependent: :destroy
  accepts_nested_attributes_for :damage_resistances, allow_destroy: true, reject_if: :all_blank
  has_many  :movement_rates, dependent: :destroy
  accepts_nested_attributes_for :movement_rates, allow_destroy: true, reject_if: :all_blank
  has_many  :monster_names, dependent: :destroy
  accepts_nested_attributes_for :monster_names, allow_destroy: true, reject_if: :all_blank
  has_many  :parry_scores, dependent: :destroy
  accepts_nested_attributes_for :parry_scores, allow_destroy: true, reject_if: :all_blank

  belongs_to :monster_class
  delegate :name, to: :monster_class, prefix: true

  validates :name, :monster_class_id, presence: true

  def freeform_trait_list
    ""
  end

  def freeform_trait_list=(value)
    TraitList.getList(value).each do |trait|
      self.traits << trait
    end
  end
end
