class MonsterClass < ActiveRecord::Base
  has_many :monsters, dependent: :destroy
  
  validates :name, presence: true
end
