class LocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = Location.all.pluck(:name)
  end

  def available
    @locations = Location.available_in(params[:room], params[:start].to_datetime, params[:end].to_datetime)
    render json: @locations
  end
end
