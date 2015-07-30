module CampaignContained
  extend ActiveSupport::Concern

  included do
    has_many :campaign_contents, as: :content, dependent: :destroy
    accepts_nested_attributes_for :campaign_contents, allow_destroy: true, :reject_if => lambda { |x| x['campaign_id'].blank? }

    scope :in_campaign, -> (campaign_id) { joins(:campaign_contents).where(campaign_contents: {campaign_id: campaign_id}) }
  end

  def build_campaign_content
    CampaignContent.new
  end
end
