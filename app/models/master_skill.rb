# A general GURPS Skill, like Brawling or Chemistry
class MasterSkill < AbstractEntity
  include Nameable
  include PageReferenceable
  include NilBlankable

  belongs_to :characteristic
  before_validation :nil_blank_attributes
  has_many :skills

  validates :characteristic, presence: true

  def to_s
    "#{name} (#{characteristic})"
  end

  private

  def blankable_attributes
    [:name, :notes]
  end
end
