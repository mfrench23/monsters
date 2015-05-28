class DamageResistance < ActiveRecord::Base
  belongs_to :creature
  belongs_to :location
end
