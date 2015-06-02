class SwarmForm
  attr_reader :params

  def initialize(params=nil)
    @params = monster_params(params)
  end

  private

    def monster_params(params)
      params.require(:swarm).permit(
        :name,
	:description, :notes,
        :monster_class_id,
	:parts_value,
	:number_description,
        :ancestry,
	illustrations_attributes: [:id, :image, :notes, :_destroy],
        monster_names_attributes: [:id, :name, :description, :_destroy],
        attacks_attributes: [:id, :name, :skill, :description, :_destroy],
        movement_rates_attributes: [:id, :move_type_id, :rate, :enhanced_rate, :_destroy],
        page_references_attributes: [:id, :book_id, :pages, :_destroy],
	characteristic_monsters_attributes: [:id, :characteristic_id, :score] )
    end
end
