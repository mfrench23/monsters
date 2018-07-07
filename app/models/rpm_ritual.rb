# A ritual, as defined in GURPS Thaumatology: Ritual Path Magic; a collection
# of spell effects and spell modifiers, some inherent and some optional, to
# produce a single magical effect at a cost based on its elements.
class RpmRitual < AbstractEntity
  include CampaignContained
  include PageReferenceable
  include Nameable

  belongs_to :campaign

  has_many :rpm_spell_effects, dependent: :destroy
  accepts_nested_attributes_for :rpm_spell_effects, allow_destroy: true

  has_many :rpm_ritual_modifiers, dependent: :destroy
  accepts_nested_attributes_for :rpm_ritual_modifiers, allow_destroy: true

  after_save :calculate_cost

  validates_uniqueness_of :name, :scope => :campaign_id

  scope :with_path, -> (path_id) { where(:id => RpmSpellEffect.where(:rpm_path => RpmPath.where(:id => path_id)).pluck(:rpm_ritual_id)) }

  def inherent_cost_factor
    RpmRitual.sum_cost_factor(rpm_spell_effects.inherent_only)
  end

  def overall_cost_factor
    [1, RpmRitual.sum_cost_factor(rpm_spell_effects)].max
  end

  def all_elements
    (rpm_spell_effects + rpm_ritual_modifiers)
  end

  def all_inherent_elements
    (rpm_spell_effects.inherent_only + rpm_ritual_modifiers.inherent_only)
  end

  def base_cost
    all_elements.sum(&:cost)
  end
  
  def deep_copy
    copy = dup
    reference_list_attributes.each { |reference| deep_copy_reference(reference, copy) }
    copy
  end

  def self.calc_effective_skill(for_cost)
    return ((for_cost-75)/10)+21 if for_cost > 75
    return 21 if for_cost > 65
    return 20 if for_cost > 55
    return 19 if for_cost > 42
    return 18 if for_cost > 29
    return 17 if for_cost > 15
    return 16 if for_cost > 11
    return 15 if for_cost > 9
    return 14 if for_cost > 7
    return 13 if for_cost > 6
    return 12 if for_cost > 5
    return 11 if for_cost > 4
    return 10 if for_cost > 3
    return 9 if for_cost > 2
    return 8 if for_cost > 1
    return 7
  end

  private

  def reference_list_attributes
    [:rpm_spell_effects, :rpm_ritual_modifiers, :page_references]
  end

  def calc_inherent_base_cost
    all_inherent_elements.sum(&:cost)
  end

  def self.sum_cost_factor(mods)
    mods.greater_effect.inject(1) { |sum, eff| sum + eff.rpm_potency_cost_factor }
  end

  def calculate_cost
    self.update_columns(:inherent_cost => calc_inherent_base_cost * inherent_cost_factor,
                        :typical_cost => base_cost * overall_cost_factor,
                        :effective_skill => RpmRitual.calc_effective_skill(base_cost * overall_cost_factor))
  end
end
