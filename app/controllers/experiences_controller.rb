class ExperiencesController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[new create edit update destroy]

  # Needs Profile and Experiences Models
  def index
    @profile = Profile.find(params[:profile_id])
    @experiences = @profile.experiences
  end

  def show
    @profile = Profile.find(params[:profile_id])
    @experience = Experience.find(params[:id])
  end
end