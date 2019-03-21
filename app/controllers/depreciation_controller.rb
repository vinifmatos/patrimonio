# frozen_string_literal: true

class DepreciationController < ApplicationController
  def index
    if params[:kind].blank?
      @goods = Good.active.order(:code)
    else
      sub_kinds = params[:sub_kind].blank? ? GoodSubKind.where(good_kind_id: params[:kind]).pluck(:id) : params[:sub_kind]
      categories = params[:category].blank? ? GoodCategory.where(good_sub_kind_id: sub_kinds).pluck(:id) : params[:category]
      @goods = Good.active.where(good_category_id: (params[:category].blank? ? categories : params[:category])).order(:code)
    end
    @kinds = (GoodKind.all.select(:id, :description).map { |k| [k.description, k.id] }).sort

    @categories = (GoodSubKind.select(:id).map { |sk| { "#{sk.id}": [GoodCategory.where(good_sub_kind_id: sk.id).select(:id, :description).map { |c| [c.description, c.id] }] } }).to_json
  end

  def get_sub_kinds
    @sub_kinds = (GoodSubKind
      .where(good_kind_id: params[:kind])
      .select(:id, :description).map { |sk| [sk.description, sk.id] }).sort
  end

  def get_categories
    @categories = (GoodCategory
      .where(good_sub_kind_id: params[:sub_kind])
      .select(:id, :description).map { |c| [c.description, c.id] }).sort
  end
end
