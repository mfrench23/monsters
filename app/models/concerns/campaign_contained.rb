module CampaignContained
  extend ActiveSupport::Concern

  included do
    has_many :campaign_contents, as: :content, dependent: :destroy
    accepts_nested_attributes_for :campaign_contents, allow_destroy: true, :reject_if => lambda { |x| x['campaign_id'].blank? }
  end

  def build_campaign_content
    CampaignContent.new
  end
end
