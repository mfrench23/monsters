class MonsterName < ActiveRecord::Base
  belongs_to :monster
  
  
  def <=>(other)
    return nil unless other.is_a?(MonsterName)
    
    (( self.primary ? 1 : 2 ) <=> ( other.primary ? 1 : 2 )).nonzero? ||
	(self.name <=> other.name).nonzero? ||
	0
  end
end
