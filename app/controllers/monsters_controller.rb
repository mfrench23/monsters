class MonstersController < ApplicationController
  before_action :set_monster, only: [:show, :edit, :update, :destroy]

  # GET /monsters
  # GET /monsters.json
  def index
    @monsters = Monster.all
  end

  # GET /monsters/1
  # GET /monsters/1.json
  def show
  end

  # GET /monsters/new
  def new
    @monster = Monster.new
    @monster.monster_names.build
    @monster.attacks.build
    @monster.movement_rates.build
  end

  # GET /monsters/1/edit
  def edit
  end

  # POST /monsters
  # POST /monsters.json
  def create
    @monster = Monster.new(monster_params)

    respond_to do |format|
      if @monster.save
	format.html { redirect_to @monster, notice: 'Monster was successfully created.' }
	format.json { render :show, status: :created, location: @monster }
      else
	format.html { render :new }
	format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monsters/1
  # PATCH/PUT /monsters/1.json
  def update
    @monster = Monster.find(params[:id])
    respond_to do |format|
      if @monster.update(monster_params)
	format.html { redirect_to @monster, notice: 'Monster was successfully updated.' }
	format.json { render :show, status: :ok, location: @monster }
      else
	format.html { render :edit }
	format.json { render json: @monster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monsters/1
  # DELETE /monsters/1.json
  def destroy
    @monster.destroy
    respond_to do |format|
      format.html { redirect_to monsters_url, notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monster
      @monster = Monster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monster_params
      params.require(:monster).permit(
	:strength, :dexterity, :intelligence, :health, :hitPoints, :will, 
        :perception, :fatigue, :speed, :sizeModifier, :height, 
        :weight, :gear, :description, :notes, :dodge, :block,
	:monster_class_id,
        monster_names_attributes: [:id, :name, :primary, :description, :_destroy],
        attacks_attributes: [:id, :name, :skill, :description, :_destroy],
        movement_rates_attributes: [:id, :terrain_type_id, :rate, :_destroy],
        damage_resistances_attributes: [:id, :location_id, :dr, :notes, :_destroy],
	page_references_attributes: [:id, :book_id, :pages, :_destroy],
	parry_scores_attributes: [:id, :weapon, :parry, :_destroy],
	skills_attributes: [:id, :name, :trait, :modifier, :_destroy],
	traits_attributes: [:id, :name, :description, :is_feature, :level, :_destroy] )
    end
end
