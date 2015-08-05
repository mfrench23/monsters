class EquipmentPackage < ActiveRecord::Base
  include EquipmentOwning

  belongs_to :creature
end
