class LocationsController < ApplicationController
  def index
    @locations = Location.all.pluck(:name)
  end
end