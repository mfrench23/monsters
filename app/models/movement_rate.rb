class MovementRate < ActiveRecord::Base
  belongs_to :monster
  belongs_to :terrain_type
end
