class MasterSkill < ActiveRecord::Base
  belongs_to :characteristic

  validates :name, :characteristic, presence: true
end
