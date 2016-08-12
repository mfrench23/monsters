# A single, general kind of modifier for a Ritual Path Magic ritual, like "Damage" or "Range"
class RpmModifier < AbstractEntity
  include CampaignContained
  include Nameable

  belongs_to :campaign

  has_many :rpm_modifier_levels, dependent: :destroy
  accepts_nested_attributes_for :rpm_modifier_levels, allow_destroy: true

  has_many :rpm_modifier_subtypes, dependent: :destroy
  accepts_nested_attributes_for :rpm_modifier_subtypes, allow_destroy: true

  validates_uniqueness_of :name, :scope => :campaign_id

  def level_count
    rpm_modifier_levels.count
  end
end
