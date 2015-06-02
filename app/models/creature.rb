class Creature < ActiveRecord::Base
  include TraitList

  attr_accessor :freeform_trait_list

  before_save :convert_skills

  has_many  :damage_resistances, dependent: :destroy
  accepts_nested_attributes_for :damage_resistances, allow_destroy: true, reject_if: :all_blank
  has_many :skills, dependent: :destroy
  accepts_nested_attributes_for :skills, allow_destroy: true, reject_if: :all_blank
  has_many :traits, dependent: :destroy
  accepts_nested_attributes_for :traits, allow_destroy: true, reject_if: :all_blank
  has_many  :parry_scores, dependent: :destroy
  accepts_nested_attributes_for :parry_scores, allow_destroy: true, reject_if: :all_blank

  acts_as :monster

  monetize :parts_value_cents, :allow_nil => true,
      :numericality => { :greater_than_or_equal_to => 0 }

  validates :freeform_skill_list, absence: true

  def deep_copy
    copy = dup
    copy.monster = monster.deep_copy
    damage_resistances.each { |dr| copy.damage_resistances << dr.deep_copy }
    skills.each { |sk| copy.skills << sk.deep_copy }
    traits.each { |tr| copy.traits << tr.deep_copy }
    parry_scores.each { |p| copy.parry_scores << p.deep_copy }
    copy
  end

  def freeform_trait_list=(value)
    TraitList::FreeformTraitList.new(value).list.each do |trait|
      self.traits << trait
    end
  end

  def freeform_skill_list=(value)
    sl = SkillList::FreeformSkillList.new(value)
    sl.list.each do |skill|
      self.skills << skill
    end
    @freeform_skill_list = sl.text
  end

  def freeform_skill_list
    @freeform_skill_list
  end

  def convert_skills
    skills.each do |skill|
      skill.convert_actual_to_modifier(characteristic_score(skill.characteristic))
    end
  end
end
