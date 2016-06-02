# Joins many EquipmentPieces to many EquipmentModifiers. Shows what modifiers
# are applied to a particular piece of equipment.
class EquipmentPieceModifier < AbstractEntity
  belongs_to :equipment_piece
  belongs_to :equipment_modifier
end
