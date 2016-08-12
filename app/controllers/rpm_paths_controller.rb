# Controller functionality specific to the RpmPath model
class RpmPathsController < ModelBasedController

  private

  def whitelisted_entity_params
    params.fetch(:rpm_path, {}).permit(:name, :notes, :campaign_id)
  end
end
