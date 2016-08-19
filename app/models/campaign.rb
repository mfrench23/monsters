# Ties together all the data for a single GURPS campaign
class Campaign < AbstractEntity
  include Nameable

  has_many :monsters
  has_many :equipment_types
  has_many :equipment_categories
  has_many :rpm_potencies
  has_many :rpm_effects
  has_many :rpm_paths
  has_many :rpm_rituals

  has_many :random_eq_profiles, :through => :equipment_categories

  validates_uniqueness_of :name

  def self.has_contents(klass)
    Campaign.where(id: klass.uniq.pluck(:campaign_id))
  end
end
