# A potency category for a Ritual Path Magic spell effect, like "Lesser" or "Greater"
class RpmPotency < AbstractEntity
  include CampaignContained
  include Nameable

  belongs_to :campaign
  validates_uniqueness_of :name, :scope => :campaign_id
end
