class TerrainTypesController < ApplicationController
  before_action :set_terrain_type, only: [:show, :edit, :update, :destroy]

  # GET /terrain_types
  # GET /terrain_types.json
  def index
    @terrain_types = TerrainType.all
  end

  # GET /terrain_types/1
  # GET /terrain_types/1.json
  def show
  end

  # GET /terrain_types/new
  def new
    @terrain_type = TerrainType.new
  end

  # GET /terrain_types/1/edit
  def edit
  end

  # POST /terrain_types
  # POST /terrain_types.json
  def create
    @terrain_type = TerrainType.new(terrain_type_params)

    respond_to do |format|
      if @terrain_type.save
        format.html { redirect_to @terrain_type, notice: 'Terrain type was successfully created.' }
        format.json { render :show, status: :created, location: @terrain_type }
      else
        format.html { render :new }
        format.json { render json: @terrain_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /terrain_types/1
  # PATCH/PUT /terrain_types/1.json
  def update
    respond_to do |format|
      if @terrain_type.update(terrain_type_params)
        format.html { redirect_to @terrain_type, notice: 'Terrain type was successfully updated.' }
        format.json { render :show, status: :ok, location: @terrain_type }
      else
        format.html { render :edit }
        format.json { render json: @terrain_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terrain_types/1
  # DELETE /terrain_types/1.json
  def destroy
    @terrain_type.destroy
    respond_to do |format|
      format.html { redirect_to terrain_types_url, notice: 'Terrain type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_terrain_type
      @terrain_type = TerrainType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def terrain_type_params
      params.require(:terrain_type).permit(:name)
    end
end
