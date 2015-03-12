class Trait < ActiveRecord::Base
  belongs_to :monster
  
  validates :name, presence: true
end
