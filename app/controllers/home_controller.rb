class HomeController < ApplicationController
  def index
    @projects = Project.all
    @freelancers = Freelancer.all
  end
end