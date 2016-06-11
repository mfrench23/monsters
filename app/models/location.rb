# A GURPS hit location
class Location < AbstractEntity
  include UniquelyNameable

  has_many  :damage_resistances, :dependent => :destroy
end
