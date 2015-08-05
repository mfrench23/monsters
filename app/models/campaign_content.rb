class CampaignContent < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :content, polymorphic: true, touch: true

  delegate :name, to: :campaign, prefix: true

  validates_uniqueness_of :campaign_id, :scope => [:content_type, :content_id]
  validates_uniqueness_of :content_id, :scope => [:campaign_id, :content_type]

  scope :monsters, -> { where("campaign_contents.content_type = ?", Monster.to_s)}

  def deep_copy
    dup
  end
end
