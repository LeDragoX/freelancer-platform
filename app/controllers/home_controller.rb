class HomeController < ApplicationController

  def index
    if user_signed_in?
      @freelancers = Freelancer.all      
    elsif freelancer_signed_in?
      @projects = []
      Project.all.each { |project| @projects << project if project.available? }
    end
  end
end