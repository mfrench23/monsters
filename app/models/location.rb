class Location < ActiveRecord::Base
  has_many  :damage_resistances, :dependent => :destroy

  validates :name, presence: true

  def to_s
    name
  end
end
