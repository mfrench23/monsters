# Controller functionality specific to the Location model
class LocationsController < ModelBasedController

  private

  def whitelisted_entity_params
    params.require(:location).permit(:name)
  end
end
