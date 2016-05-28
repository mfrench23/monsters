# One name of several that a Monster might have. For example, the same
# creature might be considered both a "goblin" and an "orc".
class MonsterName < AbstractEntity
  validates :name, presence: true
  belongs_to :monster, touch: true

  def to_s
    name
  end

  def <=>(other)
    return nil unless other.is_a?(MonsterName)

    (self.name <=> other.name).nonzero? || 0
  end

end
