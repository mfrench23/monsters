class Trait < ActiveRecord::Base
  belongs_to :monster
  belongs_to :master_trait

  validates :master_trait, presence: true
end
