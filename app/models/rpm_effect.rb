class RpmEffect < AbstractEntity
  include CampaignContained
  include Nameable

  belongs_to :campaign

  validates_uniqueness_of :name, :scope => :campaign_id
end
