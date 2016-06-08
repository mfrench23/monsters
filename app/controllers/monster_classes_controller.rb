# Controller functionality specific to the MonsterClass model
class MonsterClassesController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:monster_class).permit(:name)
  end
end
