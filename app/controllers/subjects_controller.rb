class SubjectsController < ApplicationController
  before_action :authenticate_user!
  def index
    @subjects = Subject.all
  end
end