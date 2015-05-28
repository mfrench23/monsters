class Trait < ActiveRecord::Base
  belongs_to :creature
  belongs_to :master_trait

  validates :master_trait, presence: true

  def to_s
    (master_trait.to_s + " " + level.to_s).strip
  end
end
