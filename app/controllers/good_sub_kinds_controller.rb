class GoodSubKindsController < ApplicationController
  before_action :set_good_sub_kind, only: [:show, :edit, :update, :destroy]

  # GET /good_sub_kinds
  # GET /good_sub_kinds.json
  def index
    @good_sub_kinds = GoodSubKind.all
  end

  # GET /good_sub_kinds/1
  # GET /good_sub_kinds/1.json
  def show
  end

  # GET /good_sub_kinds/new
  def new
    @good_sub_kind = GoodSubKind.new
  end

  # GET /good_sub_kinds/1/edit
  def edit
  end

  # POST /good_sub_kinds
  # POST /good_sub_kinds.json
  def create
    @good_sub_kind = GoodSubKind.new(good_sub_kind_params)

    respond_to do |format|
      if @good_sub_kind.save
        format.html { redirect_to @good_sub_kind, notice: 'Good sub kind was successfully created.' }
        format.json { render :show, status: :created, location: @good_sub_kind }
      else
        format.html { render :new }
        format.json { render json: @good_sub_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /good_sub_kinds/1
  # PATCH/PUT /good_sub_kinds/1.json
  def update
    respond_to do |format|
      if @good_sub_kind.update(good_sub_kind_params)
        format.html { redirect_to @good_sub_kind, notice: 'Good sub kind was successfully updated.' }
        format.json { render :show, status: :ok, location: @good_sub_kind }
      else
        format.html { render :edit }
        format.json { render json: @good_sub_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /good_sub_kinds/1
  # DELETE /good_sub_kinds/1.json
  def destroy
    @good_sub_kind.destroy
    respond_to do |format|
      format.html { redirect_to good_sub_kinds_url, notice: 'Good sub kind was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good_sub_kind
      @good_sub_kind = GoodSubKind.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_sub_kind_params
      params.require(:good_sub_kind).permit(:description, :active, :good_kind_id)
    end
end
