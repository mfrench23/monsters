class Swarm < ActiveRecord::Base
  acts_as :monster

  def deep_copy
    copy = dup
    copy.monster = monster.deep_copy
    copy
  end
end
