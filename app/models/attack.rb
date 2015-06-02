class Attack < ActiveRecord::Base
  belongs_to :monster

  def deep_copy
    copy = dup
    copy
  end
end
