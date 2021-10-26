class ProfilesController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[new create edit update]
  before_action :require_log_in!, only: %i[show]

  def show
    begin
      @profile = Profile.find(params[:id])
      @experiences = @profile.experiences
    rescue => exception
      redirect_to root_path, alert: "#{t(:freelancer, scope: "activerecord.models")} não possui Perfil (#{exception.class}: #{exception})"
    end
  end

  def new
    @profile = Profile.new

    if !(freelancer_signed_in? && @profile == current_freelancer.profile)
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    end
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.freelancer = current_freelancer

    if !(freelancer_signed_in? && @profile == current_freelancer.profile)
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @profile.save
      redirect_to @profile, notice: "Perfil criado com sucesso!"
    else
      flash.now[:alert] = "Erro ao criar perfil"
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])

    if @profile.freelancer != current_freelancer
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    end
  end

  def update
    @profile = Profile.find(params[:id])

    if freelancer_signed_in? && current_freelancer.profile.nil?
      redirect_to new_profile_path, alert: "Cadastre seu perfil antes!"
    elsif @profile.freelancer != current_freelancer
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @profile.update(profile_params)
      redirect_to @profile, notice: "Perfil atualizado com sucesso!"
    else
      flash.now[:alert] = "Erro ao atualizar perfil"
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