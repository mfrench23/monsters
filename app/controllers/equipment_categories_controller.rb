# Controller functionality specific to the EquipmentCategory model
class EquipmentCategoriesController < ModelBasedController
  include Randomizable

  def randomize
    randomize_from(set_model_by_id)
  end

  private

  def whitelisted_entity_params
    params.fetch(:equipment_category, {})
      .permit(:name, random_eq_profiles_attributes: RandomEqProfileForm.permitted_attributes)
      .merge({:campaign_id => selected_campaign_id})
  end

  # Hash of locals required by _form view
  def additional_form_locals
    {}
  end

  def acceptable_filter_scopes
    [:starting_with, :created_on, :updated_on, :in_campaign]
  end
end
