class Characteristic < ActiveRecord::Base
  has_many  :characteristic_monsters, dependent: :destroy

  def to_s
    name
  end
end
