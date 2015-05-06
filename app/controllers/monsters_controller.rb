class MonstersController < ApplicationController
  before_action :set_monster, only: [:show, :edit, :update, :destroy]

  # GET /monsters
  # GET /monsters.json
  def index
    @monsters = Monster.order(:name).page params[:page]
  end

  # GET /monsters/1
  # GET /monsters/1.json
  def show
  end

  # GET /monsters/new
  def new
    @monster = Monster.new
    @monster.build_out
  end

  # GET /monsters/1/edit
  def edit
  end

  # POST /monsters
  # POST /monsters.json
  def create
    form = MonsterForm.new(params)
    service = CreateMonster.new(form)
    @monster = service.call

    respond_to do |format|
      if @monster.errors.size() == 0
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
    form = MonsterForm.new(params)
    service = UpdateMonster.new(params[:id], form)
    @monster = service.call
    respond_to do |format|
      if @monster.errors.size() == 0
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
end
