module CampaignContained
  extend ActiveSupport::Concern

  included do
    belongs_to :campaign
    delegate :name, to: :campaign, prefix: true
    scope :in_campaign, -> (campaign_id) { where(campaign_id: campaign_id) }
    validates :campaign_id, presence: true
  end
end
