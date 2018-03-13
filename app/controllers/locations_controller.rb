class LocationsController < ApplicationController
  before_action :authenticate_user!
<<<<<<< HEAD
  
  def index
    @locations = Location.all.pluck(:name)
  end
end
=======

  def index
    @locations = Location.all.pluck(:name)
  end
end
>>>>>>> origin/master
