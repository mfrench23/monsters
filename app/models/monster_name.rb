class MonsterName < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :monster, touch: true


  def <=>(other)
    return nil unless other.is_a?(MonsterName)

    (self.name <=> other.name).nonzero? ||
	0
  end

end
