class CampaignMonster < ActiveRecord::Base
  belongs_to :campaign, inverse_of: :campaign_monsters
  belongs_to :monster, inverse_of: :campaign_monsters, touch: true

  scope :order_by_monster, -> { includes(:monster).order("monsters.name") }

  delegate :name, to: :monster, prefix: true
  delegate :name, to: :campaign, prefix: true

  validates_uniqueness_of :campaign_id, :scope => [:monster_id]
  validates_uniqueness_of :monster_id, :scope => [:campaign_id]

  def deep_copy
    copy = dup
    copy
  end
end
