class SubjectsController < ApplicationController
  before_action :authenticate_user!
  def index
    @subjects = Subject.all
  end
<<<<<<< HEAD
end
=======

  def show
    @subject = Subject.find_by(code: params[:id])
  end
end
>>>>>>> origin/master
