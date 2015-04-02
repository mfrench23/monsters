class MonsterForm
  attr_reader :params

  def initialize(params=nil)
    @params = monster_params(params)
  end

  private

    def monster_params(params)
      params.require(:monster).permit(
        :name,
        :strength, :dexterity, :intelligence, :health, :hitPoints, :will,
        :perception, :fatigue, :speed, :sizeModifier, :height,
        :weight, :gear, :description, :notes, :dodge, :block,
        :monster_class_id,
	:freeform_trait_list,
        monster_names_attributes: [:id, :name, :description, :_destroy],
        attacks_attributes: [:id, :name, :skill, :description, :_destroy],
        movement_rates_attributes: [:id, :terrain_type_id, :rate, :_destroy],
        damage_resistances_attributes: [:id, :location_id, :dr, :notes, :_destroy],
        page_references_attributes: [:id, :book_id, :pages, :_destroy],
        parry_scores_attributes: [:id, :weapon, :parry, :_destroy],
        skills_attributes: [:id, :master_skill_id, :modifier, :_destroy],
        traits_attributes: [:id, :master_trait_id, :level, :_destroy] )
    end
end
