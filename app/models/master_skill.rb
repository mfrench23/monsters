class MasterSkill < ActiveRecord::Base
  enum baseStat: { ST: 1, DX: 2, IQ: 3, HT: 4, Will: 5, Per: 6 }
  
  validates :name, :baseStat, presence: true
end
