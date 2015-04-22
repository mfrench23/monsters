class ParryScore < ActiveRecord::Base
  validates :parry, presence: true
end
