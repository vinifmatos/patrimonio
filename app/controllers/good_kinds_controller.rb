# frozen_string_literal: true

class GoodKindsController < ApplicationController
  before_action :set_good_kind, only: %i[show edit update destroy]

  # GET /good_kinds
  # GET /good_kinds.json
  def index
    @good_kinds = GoodKind.all.order(:description).page(params[:page])
  end

  # GET /good_kinds/1
  # GET /good_kinds/1.json
  def show; end

  # GET /good_kinds/new
  def new
    @good_kind = GoodKind.new
  end

  # GET /good_kinds/1/edit
  def edit; end

  # POST /good_kinds
  # POST /good_kinds.json
  def create
    @good_kind = GoodKind.new(good_kind_params)

    respond_to do |format|
      if @good_kind.save
        format.html { redirect_to @good_kind, notice: 'Good kind was successfully created.' }
        format.json { render :show, status: :created, location: @good_kind }
      else
        format.html { render :new }
        format.json { render json: @good_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /good_kinds/1
  # PATCH/PUT /good_kinds/1.json
  def update
    respond_to do |format|
      if @good_kind.update(good_kind_params)
        format.html { redirect_to @good_kind, notice: 'Good kind was successfully updated.' }
        format.json { render :show, status: :ok, location: @good_kind }
      else
        format.html { render :edit }
        format.json { render json: @good_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /good_kinds/1
  # DELETE /good_kinds/1.json
  def destroy
    @good_kind.destroy
    respond_to do |format|
      format.html { redirect_to good_kinds_url, notice: 'Good kind was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_good_kind
    @good_kind = GoodKind.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def good_kind_params
    params.require(:good_kind).permit(:description, :active)
  end
end
