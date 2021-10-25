class HomeController < ApplicationController

  def index
    @projects = Project.all
    @freelancers = Freelancer.all
    @profiles = Profile.all
  end
end