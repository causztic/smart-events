class SchedulesController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }

  def update
    session = Session.find(params[:id])
    s = {
      start_time: params[:start_time].to_datetime + 8.hours,
      end_time: params[:end_time].to_datetime + 8.hours,
    }
    if session.update_attributes(s)
      render json: { status: 'Successfully updated session.' }, status: 200
    else
      render json: { status: 'Error updating session.' }, status: 400
    end
  end
end
