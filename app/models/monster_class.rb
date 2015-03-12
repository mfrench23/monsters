class MonsterClass < ActiveRecord::Base
  has_many :monsters, dependent: :destroy
end
