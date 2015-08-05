class EquipmentPackage < ActiveRecord::Base
  include EquipmentOwning

  belongs_to :creature

  def final_owner
    creature
  end
end
