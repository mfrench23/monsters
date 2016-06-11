# A general class of monsters sharing certain attributes, like "Elementals"
# or "Dire Animals".
class MonsterClass < AbstractEntity
  include UniquelyNameable

  has_many :monsters, dependent: :destroy
end
