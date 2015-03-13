class Skill < ActiveRecord::Base
  belongs_to :monster
  
  enum baseStat: { ST: 1, DX: 2, IQ: 3, HT: 4, Will: 5, Per: 6 }
  
  validates :name, :baseStat, :modifier, presence: true
end
