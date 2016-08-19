# Controller functionality specific to the RpmPath model
class RpmPathsController < ModelBasedController

  private

  def acceptable_filter_scopes
    [:starting_with, :in_campaign]
  end

  def whitelisted_entity_params
    params.fetch(:rpm_path, {}).permit(:name, :notes, :campaign_id,
                                       page_references_attributes: [:id, :book_id, :pages, :_destroy])
  end
end
