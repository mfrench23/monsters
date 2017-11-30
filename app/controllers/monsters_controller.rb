# Controller functionality specific to the Monster model
class MonstersController < ModelBasedController
  private

  def additional_index_locals
    {campaigns: all_campaigns_with_monsters.order_by_name}
  end

  def includes_for_sorting
    [:monster_names, :monster_class]
  end

  def all_campaigns_with_monsters
    Campaign.has_contents(Monster)
  end

  def acceptable_filter_scopes
    [:starting_with, :created_on, :updated_on, :in_campaign]
  end
end
