class ExperiencesController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[new create edit update destroy]

  # Needs Profile and Experiences Models
  def index
    @profile = Profile.find(params[:profile_id])
    @experiences = @profile.experiences
  end

  def show
    @experience = Experience.find(params[:id])
  end

  def new
    @profile = Profile.find(params[:profile_id])
    @experience = Experience.new
  end
  
  def create
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.new(experience_params)

    if @experience.save
      redirect_to [@profile, @experience]
    else
      render :new
    end
  end
  
  def edit
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])
  end
  
  def update
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])

    if @experience.update(experience_params)
      redirect_to [@profile, @experience]
    else
      render :edit
    end
  end
  
  def destroy
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])

    if @experience.destroy
      redirect_to profile_experiences_path
    else
      render :show
    end
  end

  private
  
  def experience_params
    params.require(:experience).permit(:title, :started_at, :ended_at,
                                       :description, :profile_id)
  end
end