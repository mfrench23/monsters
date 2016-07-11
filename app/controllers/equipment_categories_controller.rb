# Controller functionality specific to the EquipmentCategory model
class EquipmentCategoriesController < ModelBasedController
  include Randomizable

  def merge_into
    display_merge_into_page
  end

  def do_merge_into
    merge_into = EquipmentCategory.find(params[:merge_into_equipment_category_id])
    redirect_after_merge merge_into.merge(set_model_by_id), merge_into
  end

  def randomize
    randomize_from(set_model_by_id)
  end

  private

  def redirect_after_merge(successful, merged_into)
    if successful
      redirect_to merged_into, notice: 'Equipment Categories were successfully merged.'
    else
      display_merge_into_page 'Unable to merge.'
    end
  end

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

  def display_merge_into_page(notice=nil)
    ec = set_model_by_id
    render :merge_into, locals: { :equipment_category => ec, :selection_list => EquipmentCategory.where.not(:id => ec.id).order_by_name }, notice: notice
  end
end
