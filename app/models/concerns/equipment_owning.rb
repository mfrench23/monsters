module EquipmentOwning
  extend ActiveSupport::Concern

  included do
    has_many :equipment_pieces, as: :owner, dependent: :destroy
    accepts_nested_attributes_for :equipment_pieces, allow_destroy: true, :reject_if => lambda { |equipment_piece| equipment_piece['equipment_type_id'].blank? }
  end

  def build_equipment_piece
    EquipmentPiece.new
  end

  def final_owner
    self
  end
end
