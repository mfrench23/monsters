class MasterSkill < AbstractEntity
  belongs_to :characteristic
  before_validation :nil_blank_attributes
  has_many :skills

  validates :name, :characteristic, presence: true

  def to_s
    "#{name} (#{characteristic})"
  end

  private

  def nil_blank_attributes
    [:name, :notes].each do |attr|
      self[attr] = nil if self[attr].blank?
    end
  end
end
