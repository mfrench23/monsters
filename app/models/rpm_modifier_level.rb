class RpmModifierLevel < ActiveRecord::Base
  belongs_to :rpm_modifier
  has_one :campaign, :through => :rpm_modifier
  scope :in_campaign, -> (campaign_id) { joins(:rpm_modifier).where(rpm_modifiers: {campaign_id: campaign_id}) }
  scope :order_by_cost, -> { order([:cost, :description]) }
end
