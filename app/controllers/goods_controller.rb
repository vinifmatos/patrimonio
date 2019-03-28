# frozen_string_literal: true

class GoodsController < ApplicationController
  before_action :set_good, only: %i[edit update destroy departments]
  before_action :set_kinds, only: %i[new edit create update]
  before_action :set_sub_kinds, only: %i[new edit create update]
  before_action :set_categories, only: %i[new edit create update]
  before_action :set_departments, only: %i[new edit create update]
  before_action :set_situations, only: %i[new edit create update]

  # GET /goods
  # GET /goods.json
  def index
    @goods = Good.all.includes(:category, :department, :situation).order(:code).page(params[:page])
  end

  # GET /goods/1
  # GET /goods/1.json
  def show
    @good = Good.includes(
      :situation,
      movements: { department: :property },
      category: { sub_kind: :kind },
      financial_movements: :kind
    ).find(params[:id])

    set_avaliable_departments

    @movement_kinds = MovementKind.select(:id, :description).find(1, 2).map { |k| [MovementKind.t(k.description), k.id] }
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

  def departments
    set_avaliable_departments
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

  def set_categories
    @categories = GoodSubKind.active.select(:id).map { |sk| [sk.id, sk.categories.active.map { |c| [c.description, c.id] }] }
  end

  def set_departments
    @departments = Department.all.map { |d| [d.description, d.id] }
  end

  def set_situations
    @situations = GoodSituation.all.map { |s| [GoodSituation.t(s.description), s.id] }
  end

  def set_avaliable_departments
    @departments = (Property.includes(:departments).where.not(departments: { id: @good.movements.last.department_id }).map do |p|
      [p.description, p.departments.map { |d| [d.description, d.id] }.sort]
    end).sort
  end

  def set_kinds
    @kinds = GoodKind.active.select(:id, :description).map { |k| [k.description, k.id] }
  end

  def set_sub_kinds
    @sub_kinds = GoodKind.active.map do |k|
      [k.id, k.sub_kinds.active.select(:id, :description).map { |sk| [sk.description, sk.id] }]
    end
  end
end
