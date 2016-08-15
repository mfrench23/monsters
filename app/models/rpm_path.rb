# One Ritual Path Magic path, like "Mind" or "Spirit" or "Undead"
class RpmPath < AbstractEntity
  include CampaignContained
  include Nameable
  include PageReferenceable

  belongs_to :campaign
  has_many :rpm_spell_effects
  has_many :rpm_rituals, :through => :rpm_spell_effects
  validates_uniqueness_of :name, :scope => :campaign_id
end
