class Skill < ActiveRecord::Base
  belongs_to :monster
  belongs_to :master_skill

  has_one :characteristic, :through => :master_skill

  validates :master_skill, :modifier, presence: true

  def to_s
    mod = Modifier.new(modifier)
    actual = mod.actual( monster.try(:characteristic_score, characteristic) )
    master_skill.name + " @" + characteristic.to_s + mod.to_s + (actual.nil? ? "" : "=" + actual.to_s )
  end
end
