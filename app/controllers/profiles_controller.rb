class ProfilesController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[new create edit update]

  def show
    begin
      @profile = Profile.find(params[:id])
      @experiences = @profile.experiences
    rescue => exception
      if !user_signed_in? && freelancer_signed_in?
        redirect_to new_profile_path, alert: "#{t(:freelancer, scope: "activerecord.models")} não possui Perfil (#{exception.class}: #{exception})"
      else
        redirect_to root_path, alert: "#{t(:freelancer, scope: "activerecord.models")} não possui Perfil (#{exception.class}: #{exception})"
      end
    end
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.freelancer = current_freelancer

    if @profile.save
      redirect_to @profile
    else
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])

    if freelancer_signed_in? && current_freelancer.profile.nil?
      redirect_to new_profile_path, alert: "[UPDATE] Cadastre seu perfil antes! ✋🏻😡"
    elsif @profile.freelancer != current_freelancer
      redirect_to root_path, alert: "[UPDATE] Perfil diferente e não alterado! ✋🏻😡"
    elsif @profile.update(profile_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:full_name, :social_name, :birth_date,
                                    :formation, :description, :photo,
                                    :occupation_area_id, :freelancer_id)
  end
end