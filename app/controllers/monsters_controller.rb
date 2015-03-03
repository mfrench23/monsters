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
  end

  # GET /monsters/1/edit
  def edit
  end

  # POST /monsters
  # POST /monsters.json
  def create
    @monster = Monster.new(monster_params)

    if params[:add_monster_name]
      # add a new, empty name
      @monster.monster_names.build
      render :action => 'new'
    elsif params[:remove_monster_name]
      # do nothing, handled by the model
      render :action => 'new'
    else
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
  end

  # PATCH/PUT /monsters/1
  # PATCH/PUT /monsters/1.json
  def update
    @monster = Monster.find(params[:id])
    if params[:add_monster_name ]
      # rebuild the names that don't have id's
      unless params[:monster][:monster_names_attributes].blank?
	for attribute in params[:monster][:monster_names_attributes]
	  @monster.monster_names.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
	end
      end
      # and add one more
      @monster.monster_names.build
      render :action => 'edit'
    elsif params[:remove_monster_name]
      # collect all marked for delete
      removed_names = params[:monster][:monster_names_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1 ) }
      # remove from db
      MonsterName.delete(removed_names)
      for attribute in params[:monster][:monster_names_attributes]
	@monster.monster_names.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
      end
      render :action => 'edit', :notice => "Aliases removed."
    else
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
      params.require(:monster).permit(:strength, 
                                      :dexterity, :intelligence, :health, :hitPoints, :will, 
                                      :perception, :fatigue, :speed, :sizeModifier, :height, 
                                      :weight, :gear, :description, :notes, :dodge, :block,
                                      monster_names_attributes: [:id, :name, :primary, :description, :_destroy])
    end
end
