class LocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = Location.all.pluck(:name)
  end

  def available
    @locations = Location.available_in(params[:start], params[:end])
  end
end
