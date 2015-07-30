class MonstersController < ApplicationController
  def index
    render locals: {
      monsters: filtered_sorted_paginated_results,
      filter_params: filter_params(params),
      starts_with_tags: first_characters_in_results,
      campaigns: all_campaigns_with_monsters.order_by_name,
      campaign_name: name_of_filtering_campaign
    }
  end

  private

  def first_characters_in_results
    filtered_results(params).group("substr(upper(name), 1,1)").count.keys.sort
  end

  def filtered_sorted_paginated_results
    filtered_sorted_results.page(params[:page])
  end

  def filtered_sorted_results
    filtered_results(params).includes(:monster_names, :monster_class).order(sort_params)
  end

  def sort_params
    view_context.sort_param(Monster, params[:sort], params[:direction])
  end

  def all_campaigns_with_monsters
    Campaign.has_contents(Monster.to_s)
  end

  def filtered_results(params)
    Monster.filter(filter_params(params))
  end

  def filter_params(params)
    params.slice(:starting_with, :created_on, :updated_on, :in_campaign)
  end
end
