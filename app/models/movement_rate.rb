class MovementRate < ActiveRecord::Base
  belongs_to :monster
  belongs_to :terrain_type
  delegate :name, to: :terrain_type, prefix: true, allow_nil: true
end
