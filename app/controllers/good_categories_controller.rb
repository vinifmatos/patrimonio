# frozen_string_literal: true

class GoodCategoriesController < ApplicationController
  before_action :set_good_category, only: %i[show edit update destroy]
  before_action :set_sub_kinds, only: %i[new edit]

  # GET /good_categories
  # GET /good_categories.json
  def index
    @good_categories = GoodCategory.all.includes(:good_sub_kind)
  end

  # GET /good_categories/1
  # GET /good_categories/1.json
  def show; end

  # GET /good_categories/new
  def new
    @good_category = GoodCategory.new
  end

  # GET /good_categories/1/edit
  def edit; end

  # POST /good_categories
  # POST /good_categories.json
  def create
    @good_category = GoodCategory.new(good_category_params)

    respond_to do |format|
      if @good_category.save
        format.html { redirect_to @good_category, notice: 'Good category was successfully created.' }
        format.json { render :show, status: :created, location: @good_category }
      else
        format.html { render :new }
        format.json { render json: @good_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /good_categories/1
  # PATCH/PUT /good_categories/1.json
  def update
    respond_to do |format|
      if @good_category.update(good_category_params)
        format.html { redirect_to @good_category, notice: 'Good category was successfully updated.' }
        format.json { render :show, status: :ok, location: @good_category }
      else
        format.html { render :edit }
        format.json { render json: @good_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /good_categories/1
  # DELETE /good_categories/1.json
  def destroy
    @good_category.destroy
    respond_to do |format|
      format.html { redirect_to good_categories_url, notice: 'Good category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_good_category
    @good_category = GoodCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def good_category_params
    params.require(:good_category).permit(:description, :active, :good_sub_kind_id)
  end

  def set_sub_kinds
    @sub_kinds = GoodSubKind.all.select(:id, :description).map { |x| [x.description, x.id] }
  end
end
