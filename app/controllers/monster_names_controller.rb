class MonsterNamesController < ApplicationController
  before_action :set_monster_name, only: [:show, :edit, :update, :destroy]

  # GET /monster_names
  # GET /monster_names.json
  def index
    @monster_names = MonsterName.all
  end

  # GET /monster_names/1
  # GET /monster_names/1.json
  def show
  end

  # GET /monster_names/new
  def new
    @monster_name = MonsterName.new
  end

  # GET /monster_names/1/edit
  def edit
  end

  # POST /monster_names
  # POST /monster_names.json
  def create
    @monster_name = MonsterName.new(monster_name_params)

    respond_to do |format|
      if @monster_name.save
        format.html { redirect_to @monster_name, notice: 'Monster name was successfully created.' }
        format.json { render :show, status: :created, location: @monster_name }
      else
        format.html { render :new }
        format.json { render json: @monster_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monster_names/1
  # PATCH/PUT /monster_names/1.json
  def update
    respond_to do |format|
      if @monster_name.update(monster_name_params)
        format.html { redirect_to @monster_name, notice: 'Monster name was successfully updated.' }
        format.json { render :show, status: :ok, location: @monster_name }
      else
        format.html { render :edit }
        format.json { render json: @monster_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monster_names/1
  # DELETE /monster_names/1.json
  def destroy
    @monster_name.destroy
    respond_to do |format|
      format.html { redirect_to monster_names_url, notice: 'Monster name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monster_name
      @monster_name = MonsterName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monster_name_params
      params.require(:monster_name).permit(:monster_id, :primary, :name, :notes)
    end
end
