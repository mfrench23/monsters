class CreaturesController < ApplicationController
  def show
    render locals: { creature: set_creature }
  end

  def new
    creature = Creature.new
    creature.movement_rates.build
    creature.attacks.build
    render locals: { creature: creature, campaigns: all_campaigns }
  end

  def variant
    creature = set_creature.deep_copy
    render :new, locals: { creature: creature, campaigns: all_campaigns }
  end

  def edit
    render locals: { creature: set_creature, campaigns: all_campaigns }
  end

  def create
    form = CreatureForm.new(params)
    creature = Creature.new(form.params)
    creature.save

    respond_to do |format|
      if creature.errors.size() == 0
	format.html { redirect_to creature, notice: 'Monster was successfully created.' }
	format.json { render :show, status: :created, location: creature }
      else
	format.html { render :new, locals: {creature: creature, campaigns: all_campaigns} }
	format.json { render json: creature.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    form = CreatureForm.new(params)
    creature = set_creature
    creature.update(form.params)
    respond_to do |format|
      if creature.errors.size() == 0
	format.html { redirect_to creature, notice: 'Monster was successfully updated.' }
	format.json { render :show, status: :ok, location: creature }
      else
	format.html { render :edit, locals: {creature: creature, campaigns: all_campaigns} }
	format.json { render json: creature.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_creature.destroy
    respond_to do |format|
      format.html { redirect_to monsters_url, notice: 'Monster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_creature
    Creature.find(params[:id])
  end
end
