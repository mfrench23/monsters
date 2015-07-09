class MonstersController < ApplicationController
  def index
    render locals: {
      monsters: filtered_results(params).includes(:monster_names, :monster_class).order(view_context.sort_param(Monster, params[:sort], params[:direction])).page(params[:page]),
      filter_params: filter_params(params),
      starts_with_tags: filtered_results(params).group("substr(upper(name), 1,1)").count.keys.sort,
      campaigns: all_campaigns_with_monsters.order_by_name,
      campaign_name: params[:in_campaign].nil? ? nil : Campaign.find(params[:in_campaign]).name
    }
  end

  private

  def all_campaigns_with_monsters
    Campaign.joins(:campaign_monsters).group("campaigns.id").having("count(campaign_monsters.monster_id) > ?", 0)
  end

  def filtered_results(params)
    Monster.filter(filter_params(params))
  end

  def filter_params(params)
    params.slice(:starting_with, :created_on, :updated_on, :in_campaign)
  end
end
