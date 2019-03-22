# frozen_string_literal: true

class DepreciationController < ApplicationController
  def index
    if params[:kind].blank?
      @goods = params[:goods].blank? ? Good.active.order(:code) : Good.active.where(id: params[:goods].split(',')).order(:code)
    else
      sub_kinds = params[:sub_kind].blank? ? GoodSubKind.where(good_kind_id: params[:kind]).pluck(:id) : params[:sub_kind]
      categories = params[:category].blank? ? GoodCategory.where(good_sub_kind_id: sub_kinds).pluck(:id) : params[:category]
      good_params = { good_category_id: (params[:category].blank? ? categories : params[:category]) }
      good_params[:id] = params[:goods].split(',') unless params[:goods].blank?
      @goods = Good.active.where(good_params).order(:code)
    end

    @kinds = (GoodKind.all.select(:id, :description).map { |k| [k.description, k.id] }).sort

    @sub_kinds = (GoodKind.all.includes(:sub_kinds).map do |k|
      [k.id, k.sub_kinds.map { |sk| [sk.description, sk.id] }.sort]
    end).sort

    @categories = (GoodSubKind.all.includes(:categories).map do |sk|
      [sk.id, sk.categories.map { |c| [c.description, c.id] }.sort]
    end).sort
  end
end
