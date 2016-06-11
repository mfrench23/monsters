# All the data for a single GURPS campaign
class Campaign < AbstractEntity
  include UniquelyNameable

  has_many :campaign_contents, dependent: :destroy, inverse_of: :campaign
  accepts_nested_attributes_for :campaign_contents, allow_destroy: true

  has_many :monsters, :through => :campaign_contents, :source => :content, :source_type => Monster.to_s
  has_many :equipment_types, :through => :campaign_contents, :source => :content, :source_type => EquipmentType.to_s

  scope :has_contents, -> (content_type) { joins(:campaign_contents).where("campaign_contents.content_type = ?", "#{content_type}").group("campaigns.id").having("count(campaign_contents.content_id) > ?", 0) }
end
