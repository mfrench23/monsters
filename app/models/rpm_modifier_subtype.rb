class RpmModifierSubtype < ActiveRecord::Base
  include Nameable

  belongs_to :rpm_modifier
end
