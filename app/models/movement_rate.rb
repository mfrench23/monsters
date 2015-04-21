class MovementRate < ActiveRecord::Base
  belongs_to :monster
  belongs_to :move_type
  delegate :name, to: :move_type, prefix: true, allow_nil: true
end
