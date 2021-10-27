class HomeController < ApplicationController

  def index
    @projects = []
    Project.all.each { |project| @projects << project if project.available? }
    @freelancers = Freelancer.all
  end
end