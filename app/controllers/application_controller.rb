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

  def name_of_filtering_campaign
    Campaign.find(params[:in_campaign]).name unless params[:in_campaign].nil?
  end

  def name_of_filtering_equipment_category
    EquipmentCategory.find(params[:in_equipment_category]).name unless params[:in_equipment_category].nil?
  end

  def all_campaigns
    Campaign.all
  end
end
