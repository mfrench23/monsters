class Campaign < ActiveRecord::Base
  has_many :campaign_monsters, dependent: :destroy, inverse_of: :campaign
  accepts_nested_attributes_for :campaign_monsters, allow_destroy: true

  has_many :monsters, :through => :campaign_monsters

  scope :order_by_name, -> { order(:name) }
end
