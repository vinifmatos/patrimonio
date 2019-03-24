# frozen_string_literal: true

class DepreciationsController < ApplicationController
  # before_action :set_goods, only: %i[new create]
  before_action :set_kinds, only: %i[new create]
  before_action :set_sub_kinds, only: %i[new create]
  before_action :set_categories, only: %i[new create]

  def index; end

  def new
    @filters_params = {
      kind_id: '',
      sub_kind_id: '',
      category_id: '',
      goods: ''
    }

    set_goods
  end

  def create
    if params[:depreciation].present?
      @depreciation_params = params[:depreciation]
      @filters_params = params[:depreciation][:filters]
    else
      @filters_params = params[:filters]
    end

    set_goods

    if @filters_params[:kind_id].blank?
      if @filters_params[:goods].blank?
        flash[:alert] = t('views.depreciations.blank_filters')
        render :new
        return
      end

      @goods_ids = @filters_params[:goods].split(',')
    else
      sub_kinds = @filters_params[:sub_kind_id].blank? ? GoodSubKind.where(good_kind_id: @filters_params[:kind_id]).pluck(:id) : @filters_params[:sub_kind_id]
      categories = @filters_params[:category_id].blank? ? GoodCategory.where(good_sub_kind_id: sub_kinds).pluck(:id) : @filters_params[:category_id]
      good_params = { good_category_id: (@filters_params[:category_id].blank? ? categories : @filters_params[:category_id]) }
      good_params[:id] = @filters_params[:goods].split(',') unless @filters_params[:goods].blank?
      @goods_ids = Good.active.where(good_params).pluck(:id)
    end

    if !@depreciation_params.present?
      render :new
      return
    else
      if @depreciation_params.try(:fetch, :movement_date).blank?
        flash[:error] = t('views.depreciations.blank_date')
        render :new
        return
      end
    end
    DepreciationJob.perform_later(@goods_ids, @depreciation_params[:movement_date], current_user.id)
    redirect_to depreciations_path, notice: t('views.depreciations.processing')
  end

  def get_depreciation_jobs
    @jobs = Job.where(user: current_user, kind: :depreciation).order(:started_at).map do |job|
      status = ActiveJob::Status.get(job.job_id)
      { started_at: I18n.l(job.started_at, format: :short),
        progress: (status.progress > 0 ? status.progress : 0),
        status: status.status }
    end
  end

  private

  def set_goods
    if @filters_params[:kind_id].blank?
      @goods = @filters_params[:goods].blank? ? Good.active.order(:code) : Good.active.where(id: @filters_params[:goods].split(',')).order(:code)
    else
      sub_kinds = @filters_params[:sub_kind_id].blank? ? GoodSubKind.where(good_kind_id: @filters_params[:kind_id]).pluck(:id) : @filters_params[:sub_kind_id]
      categories = @filters_params[:category_id].blank? ? GoodCategory.where(good_sub_kind_id: sub_kinds).pluck(:id) : @filters_params[:category_id]
      good_params = { good_category_id: (@filters_params[:category_id].blank? ? categories : @filters_params[:category_id]) }
      good_params[:id] = @filters_params[:goods].split(',') unless @filters_params[:goods].blank?
      @goods = Good.active.where(good_params).order(:code)
    end
  end

  def set_kinds
    @kinds = [[t('views.all.male'), '']] + (GoodKind.all.select(:id, :description).map { |k| [k.description, k.id] }).sort
  end

  def set_sub_kinds
    @sub_kinds = (GoodKind.all.includes(:sub_kinds).map do |k|
                    [k.id, k.sub_kinds.map { |sk| [sk.description, sk.id] }.sort]
                  end).sort
  end

  def set_categories
    @categories = (GoodSubKind.all.includes(:categories).map do |sk|
                     [sk.id, sk.categories.map { |c| [c.description, c.id] }.sort]
                   end).sort
  end
end
