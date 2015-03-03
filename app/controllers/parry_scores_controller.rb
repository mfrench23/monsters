class ParryScoresController < ApplicationController
  before_action :set_parry_score, only: [:show, :edit, :update, :destroy]

  # GET /parry_scores
  # GET /parry_scores.json
  def index
    @parry_scores = ParryScore.all
  end

  # GET /parry_scores/1
  # GET /parry_scores/1.json
  def show
  end

  # GET /parry_scores/new
  def new
    @parry_score = ParryScore.new
  end

  # GET /parry_scores/1/edit
  def edit
  end

  # POST /parry_scores
  # POST /parry_scores.json
  def create
    @parry_score = ParryScore.new(parry_score_params)

    respond_to do |format|
      if @parry_score.save
        format.html { redirect_to @parry_score, notice: 'Parry score was successfully created.' }
        format.json { render :show, status: :created, location: @parry_score }
      else
        format.html { render :new }
        format.json { render json: @parry_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parry_scores/1
  # PATCH/PUT /parry_scores/1.json
  def update
    respond_to do |format|
      if @parry_score.update(parry_score_params)
        format.html { redirect_to @parry_score, notice: 'Parry score was successfully updated.' }
        format.json { render :show, status: :ok, location: @parry_score }
      else
        format.html { render :edit }
        format.json { render json: @parry_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parry_scores/1
  # DELETE /parry_scores/1.json
  def destroy
    @parry_score.destroy
    respond_to do |format|
      format.html { redirect_to parry_scores_url, notice: 'Parry score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parry_score
      @parry_score = ParryScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parry_score_params
      params.require(:parry_score).permit(:weapon, :parry)
    end
end
