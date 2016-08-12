# One Ritual Path Magic path, like "Mind" or "Spirit" or "Undead"
class RpmPath < AbstractEntity
  include CampaignContained
  include Nameable

  belongs_to :campaign
  validates_uniqueness_of :name, :scope => :campaign_id
end
