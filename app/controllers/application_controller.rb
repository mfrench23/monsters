# Basic functionality shared by all controllers
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def javascript_variables(variables)
    @javascript_variables ||= {}
    @javascript_variables.merge!(variables)
  end

  def name_of_filtering_equipment_category
    in_cat = params[:in_equipment_category]
    EquipmentCategory.find(in_cat).name if in_cat.present?
  end

  def name_of_filtering_modifier_category
    in_cat = params[:in_modifier_category]
    EquipmentModifierCategory.find(in_cat).name if in_cat.present?
  end

  def name_of_filtering_rpm_path
    id = params[:with_path]
    RpmPath.find(id).name if id.present?
  end

  def all_campaigns
    Campaign.all
  end

  def selected_campaign_id
    cookies[:selected_campaign] || Campaign.first.id
  end
end
