# A GURPS hit location
class Location < AbstractEntity
  include Nameable

  has_many  :damage_resistances, :dependent => :destroy
end
