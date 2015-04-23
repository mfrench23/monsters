class Skill < ActiveRecord::Base
  belongs_to :monster
  belongs_to :master_skill

  validates :master_skill, :modifier, presence: true

  def to_s
    master_skill.name + " @" + master_skill.characteristic.to_s + Modifier.new(modifier).to_s
  end
end
