class ParryScore < ActiveRecord::Base
  validates :parry_score, presence: true
end
