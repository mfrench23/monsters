class MonstersController < ApplicationController
  def index
    render locals: {
      monsters: filtered_sorted_paginated_results,
      filter_params: filter_params(params),
      starts_with_tags: first_characters_in_results(filtered_results(params)),
      campaigns: all_campaigns_with_monsters.order_by_name,
      campaign_name: name_of_filtering_campaign
    }
  end

  private

  def filtered_sorted_paginated_results
    filtered_sorted_results.page(params[:page])
  end

  def filtered_sorted_results
    filtered_results(params).includes(:monster_names, :monster_class).order(sort_params(Monster))
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
