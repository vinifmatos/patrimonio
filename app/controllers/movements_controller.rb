# frozen_string_literal: true

class MovementsController < ApplicationController
  def create
    @movement = Movement.new(movement_params)
    @movement.good = Good.find(params[:good_id])
    respond_to do |format|
      if @movement.save
        format.js { render :create, status: :created, location: @movement.good }
      else
        format.json { render json: { errors: @movement.errors }, status: :unprocessable_entity }
      end
    end
  end

  private

  def movement_params
    params.require(:movement).permit(:date, :movement_kind_id, :department_id, :good_id)
  end
end
