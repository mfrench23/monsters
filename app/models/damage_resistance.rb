class DamageResistance < ActiveRecord::Base
  belongs_to :creature
  belongs_to :location

  def deep_copy
    copy = dup
    copy
  end
end
