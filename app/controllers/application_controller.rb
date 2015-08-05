class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def javascript_variables(variables)
    @javascript_variables ||= {}
    @javascript_variables.merge!(variables)
  end

  private

  def sort_params(klass)
    view_context.sort_param(klass, params[:sort], params[:direction])
  end

  def first_characters_in_results(results)
    results.group("substr(upper(name), 1,1)").count.keys.sort
  end

  def name_of_filtering_campaign
    Campaign.find(params[:in_campaign]).name unless params[:in_campaign].nil?
  end

  def all_campaigns
    Campaign.all
  end
end
