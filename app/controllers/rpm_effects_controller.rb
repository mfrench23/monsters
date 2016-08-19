# Controller functionality specific to the RpmEffect model
class RpmEffectsController < ModelBasedController

  private

  def acceptable_filter_scopes
    [:starting_with, :in_campaign]
  end

  def permitted_attributes
    [:name, :cost, :notes, :campaign_id,
                                         page_references_attributes: [:id, :book_id, :pages, :_destroy]]
  end

  def whitelisted_entity_params
    params.fetch(:rpm_effect, {}).permit(permitted_attributes)
  end
end
