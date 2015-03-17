class Skill < ActiveRecord::Base
  belongs_to :monster
  belongs_to :master_skill
  
  enum baseStat: { ST: 1, DX: 2, IQ: 3, HT: 4, Will: 5, Per: 6 }
  
  validates :master_skill, :modifier, presence: true
end
