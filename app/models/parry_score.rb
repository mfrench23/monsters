class ParryScore < ActiveRecord::Base
  belongs_to :creature
  validates :parry, presence: true

  def deep_copy
    copy = dup
    copy
  end
end
