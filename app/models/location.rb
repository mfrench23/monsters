class Location < ActiveRecord::Base
  has_many  :damage_resistances, :dependent => :destroy
end
