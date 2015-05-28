class ParryScore < ActiveRecord::Base
  belongs_to :creature
  validates :parry, presence: true
end
