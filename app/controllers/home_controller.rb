class HomeController < ApplicationController
  def index
    @projects = Project.all
    @freelancers = Freelancer.all
    @profiles = Profile.all

    if freelancer_signed_in? && current_freelancer.profile.nil?
      redirect_to new_profile_path
    end
  end
end