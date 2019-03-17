# frozen_string_literal: true

class FinancialMovementsController < ApplicationController
  def create
    @financial_movement = FinancialMovement.new(financial_movement_params)
    @financial_movement.good = Good.find(params[:good_id])
    respond_to do |format|
      if @financial_movement.save
        format.js { render :create, status: :created, location: @financial_movement.good }
      else
        format.json { render json: { errors: @financial_movement.errors }, status: :unprocessable_entity }
      end
    end
  end

  private

  def financial_movement_params
    params.require(:financial_movement).permit(:date, :financial_movement_kind_id, :amount, :good_id)
  end
end
