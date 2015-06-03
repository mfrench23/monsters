class CharacteristicMonster < ActiveRecord::Base
  belongs_to :characteristic
  belongs_to :monster, touch: true

  def deep_copy
    copy = dup
    copy
  end
end
