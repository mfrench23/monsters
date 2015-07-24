class EquipmentPiecesController < ApplicationController
  # GET /equipment_pieces
  # GET /equipment_pieces.json
  def index
    render locals: {
      equipment_pieces: filtered_sorted_paginated_results
    }
  end

  # GET /equipment_pieces/1
  # GET /equipment_pieces/1.json
  def show
    render locals: { equipment_piece: set_equipment_piece }
  end

  # GET /equipment_pieces/new
  def new
    render locals: { equipment_piece: EquipmentPiece.new }
  end

  # GET /equipment_pieces/1/edit
  def edit
    render locals: { equipment_piece: set_equipment_piece }
  end

  # POST /equipment_pieces
  # POST /equipment_pieces.json
  def create
    equipment_piece = EquipmentPiece.new(EquipmentPieceForm.new(params).params)

    respond_to do |format|
      if equipment_piece.save
        format.html { redirect_to equipment_piece, notice: 'Equipment piece was successfully created.' }
        format.json { render :show, status: :created, location: equipment_piece }
      else
        format.html { render :new, locals: { equipment_piece: equipment_piece } }
        format.json { render json: equipment_piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment_pieces/1
  # PATCH/PUT /equipment_pieces/1.json
  def update
    equipment_piece = set_equipment_piece
    respond_to do |format|
      if equipment_piece.update(EquipmentPieceForm.new(params).params)
        format.html { redirect_to equipment_piece, notice: 'Equipment piece was successfully updated.' }
        format.json { render :show, status: :ok, location: equipment_piece }
      else
        format.html { render :edit, locals: { equipment_piece: equipment_piece } }
        format.json { render json: equipment_piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment_pieces/1
  # DELETE /equipment_pieces/1.json
  def destroy
    set_equipment_piece.destroy
    respond_to do |format|
      format.html { redirect_to equipment_pieces_url, notice: 'Equipment piece was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def filtered_sorted_paginated_results
    filtered_sorted_results.page( params[:page] )
  end

  def filtered_sorted_results
    filtered_results(params).includes(:equipment_type, :equipment_category).order(sort_params)
  end

  def filtered_results(params)
    EquipmentPiece.filter(filter_params(params))
  end

  def filter_params(params)
    params.slice(:created_on, :updated_on)
  end

  def sort_params
    view_context.sort_param(EquipmentPiece, params[:sort], params[:direction])
  end

  def set_equipment_piece
    EquipmentPiece.find(params[:id])
  end
end
