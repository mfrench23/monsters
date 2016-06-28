# Ties together all the data for a single GURPS campaign
class Campaign < AbstractEntity
  include UniquelyNameable

  has_many :monsters
  has_many :equipment_types

  def self.has_contents(klass)
    Campaign.where(id: klass.uniq.pluck(:campaign_id))
  end
end
