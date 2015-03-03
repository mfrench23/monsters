class DamageResistance < ActiveRecord::Base
  belongs_to :monster
  belongs_to :location
end
