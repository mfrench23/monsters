class CharacteristicMonster < ActiveRecord::Base
  belongs_to :characteristic
  belongs_to :monster
end
