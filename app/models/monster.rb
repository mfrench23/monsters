class Monster < ActiveRecord::Base
  include TraitList

  attr_accessor :freeform_trait_list

  before_save :convert_skills

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
  has_many  :characteristic_monsters, dependent: :destroy
  accepts_nested_attributes_for :characteristic_monsters, allow_destroy: true, reject_if: :all_blank

  has_many :characteristics, :through => :characteristic_monsters

  belongs_to :monster_class
  delegate :name, to: :monster_class, prefix: true

  has_many :illustrations, :as => :illustratable
  accepts_nested_attributes_for :illustrations, allow_destroy: true, :reject_if => lambda { |x| x['image'].nil? }

  validates :name, :monster_class_id, presence: true

  def build_out
    attacks.build
    movement_rates.build
    Characteristic.find_each do |c|
      characteristic_monsters.build(characteristic: c, score: c.base_value)
    end
  end

  def freeform_trait_list=(value)
    TraitList::FreeformTraitList.new(value).list.each do |trait|
      self.traits << trait
    end
  end

  def characteristic_score(characteristic_name)
    self.characteristic_monsters.select{ |cm| cm.characteristic.name == characteristic_name.to_s}.first.try { |x| x.characteristic.normalize(x.score) }
  end

  # All the monster's aliases, in a semicolon-delimited list.
  def names_to_s
    monster_names.sort.collect { |x| x.name }.join('; ')
  end

  def to_s
    name
  end

  def convert_skills
    skills.each do |skill|
      skill.convert_actual_to_modifier(characteristic_score(skill.characteristic))
    end
  end
end
