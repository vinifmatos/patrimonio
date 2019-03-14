# frozen_string_literal: true

class MovementsController < ApplicationController
  def create
    @movement = Movement.new(movement_params)
    @movement.good = Good.find(params[:good_id])
    respond_to do |format|
      if @movement.save
        # redirect_to good_path(@good), notice: 'Movement created'
        # format.json { render json: @movement, only: %i[code date], include: { department: { only: :description }, movement_kind: { only: :description } }, status: :created, location: @movement.good }
        format.json { render :create, status: :created, location: @movement.good }
      else
        # redirect_to good_path(@good)
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def movement_params
    params.require(:movement).permit(:date, :movement_kind_id, :department_id, :good_id)
  end
end
