class CreatureForm
  attr_reader :params

  def initialize(params=nil)
    @params = monster_params(params)
  end

  private

  def monster_params(params)
    params.require(:creature).permit(
      :name, :height, :weight, :gear,
      :description, :notes,
      :monster_class_id,
      :freeform_trait_list,
      :freeform_skill_list,
      :parts_value,
      :ancestry,
      illustrations_attributes: [:id, :image, :notes, :_destroy],
      campaign_monsters_attributes: [:id, :campaign_id, :_destroy],
      monster_names_attributes: [:id, :name, :description, :_destroy],
      attacks_attributes: [:id, :name, :skill, :description, :_destroy],
      movement_rates_attributes: [:id, :move_type_id, :rate, :enhanced_rate, :_destroy],
      damage_resistances_attributes: [:id, :location_id, :dr, :notes, :_destroy],
      page_references_attributes: [:id, :book_id, :pages, :_destroy],
      parry_scores_attributes: [:id, :weapon, :parry, :_destroy],
      skills_attributes: [:id, :master_skill_id, :modifier, :actual, :specialization, :tech_level, :notes, :_destroy],
      traits_attributes: [:id, :master_trait_id, :level, :notes, :_destroy],
      characteristic_monsters_attributes: [:id, :characteristic_id, :score] )
  end
end
