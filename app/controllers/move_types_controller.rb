# Controller functionality specific to the MoveType model
class MoveTypesController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:move_type).permit(:name)
  end
end
