# frozen_string_literal: true

class GoodsController < ApplicationController
  before_action :set_good, only: %i[edit update destroy]
  before_action :set_good_categories, only: %i[new edit]
  before_action :set_departments, only: %i[new edit]
  before_action :set_situations, only: %i[new edit]

  # GET /goods
  # GET /goods.json
  def index
    @goods = Good.all.includes(:good_category, :department, :good_situation)
  end

  # GET /goods/1
  # GET /goods/1.json
  def show
    @good = Good.includes(
      :good_situation,
      movements: { department: :property },
      good_category: { good_sub_kind: :good_kind },
      financial_movements: :financial_movement_kind
    ).find(params[:id])

    @departments = Property.all.includes(:departments).map do |p|
      [p.description, p.departments.map { |d| [d.description, d.id] }]
    end

    @movement_kids = MovementKind.all.select(:id, :description).map { |k| [MovementKind.t(k.description), k.id] }
  end

  # GET /goods/new
  def new
    @good = Good.new
  end

  # GET /goods/1/edit
  def edit; end

  # POST /goods
  # POST /goods.json
  def create
    @good = Good.new(good_params)

    respond_to do |format|
      if @good.save
        format.html { redirect_to @good, notice: 'Good was successfully created.' }
        format.json { render :show, status: :created, location: @good }
      else
        format.html { render :new }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goods/1
  # PATCH/PUT /goods/1.json
  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to @good, notice: 'Good was successfully updated.' }
        format.json { render :show, status: :ok, location: @good }
      else
        format.html { render :edit }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goods/1
  # DELETE /goods/1.json
  def destroy
    @good.destroy
    respond_to do |format|
      format.html { redirect_to goods_url, notice: 'Good was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_good
    @good = Good.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def good_params
    params.require(:good).permit(
      :code,
      :description,
      :specification,
      :situation,
      :purchase_price,
      :purchase_date,
      :base_date,
      :good_category_id,
      :department_id
    )
  end

  def set_good_categories
    @good_categories = GoodCategory.all.map { |c| [c.description, c.id] }
  end

  def set_departments
    @departments = Department.all.map { |d| [d.description, d.id] }
  end

  def set_situations
    @situations = GoodSituation.all.map { |s| [GoodSituation.t(s.description), s.id] }
  end
end
