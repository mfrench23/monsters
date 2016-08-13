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

  def inherent_cost_factor
    RpmRitual.sum_cost_factor(rpm_spell_effects.inherent_only)
  end

  def overall_cost_factor
    [1, RpmRitual.sum_cost_factor(rpm_spell_effects)].max
  end

  def all_elements
    (rpm_spell_effects + rpm_ritual_modifiers)
  end

  def base_cost
    all_elements.sum(&:cost)
  end

  private

  def calc_inherent_base_cost
    (rpm_spell_effects.inherent_only + rpm_ritual_modifiers.inherent_only).sum(&:cost)
  end

  def self.sum_cost_factor(mods)
    mods.greater_effect.inject(1) { |sum, eff| sum + eff.rpm_potency_cost_factor }
  end

  def calculate_cost
    self.update_columns(:inherent_cost => calc_inherent_base_cost * inherent_cost_factor,
                        :typical_cost => base_cost * overall_cost_factor)
  end
end
