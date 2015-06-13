class MonstersController < ApplicationController
  def index
    render locals: {
      monsters: filtered_results(params).includes(:monster_names, :monster_class).order(view_context.sort_param(Monster, params[:sort], params[:direction])).page(params[:page]),
      filter_params: filter_params(params),
      starts_with_tags: filtered_results(params).group("substr(upper(name), 1,1)").count.keys.sort
    }
  end

  private

  def filtered_results(params)
    Monster.filter(filter_params(params))
  end

  def filter_params(params)
    params.slice(:starting_with, :created_on, :updated_on)
  end
end
