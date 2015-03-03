class TerrainType < ActiveRecord::Base
  has_many  :movement_rates
end
