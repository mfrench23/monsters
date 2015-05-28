class CreaturesController < ApplicationController
  before_action :set_monster, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @creature = Creature.new
  end

  def edit
  end

  def create
    form = CreatureForm.new(params)
    @creature = Creature.new(form.params)
    @creature.save

    respond_to do |format|
      if @creature.errors.size() == 0
	format.html { redirect_to @creature, notice: 'Monster was successfully created.' }
	format.json { render :show, status: :created, location: @creature }
      else
	format.html { render :new }
	format.json { render json: @creature.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    form = CreatureForm.new(params)
    @creature = Creature.find(params[:id])
    @creature.update(form.params)
    respond_to do |format|
      if @creature.errors.size() == 0
	format.html { redirect_to @creature, notice: 'Monster was successfully updated.' }
	format.json { render :show, status: :ok, location: @creature }
      else
	format.html { render :edit }
	format.json { render json: @creature.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @creature.destroy
    respond_to do |format|
      format.html { redirect_to monsters_url, notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_monster
    @creature = Creature.includes(monster: [:monster_names, :monster_class, characteristic_monsters: [:characteristic]] ).find(params[:id])
  end
end
