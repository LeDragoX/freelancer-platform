class ProfilesController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[new create edit update]
  before_action :require_log_in!, only: %i[show]

  def show
    @profile = Profile.find(params[:id])
    @experiences = @profile.experiences
  rescue StandardError => e
    redirect_to root_path,
                alert: "#{t(:freelancer, scope: 'activerecord.models')} não possui Perfil (#{e.class}: #{e})"
  end

  def new
    @profile = Profile.new

    redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.' unless profile_exists?
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.freelancer = current_freelancer

    if !profile_exists?
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @profile.save
      redirect_to @profile, notice: 'Perfil criado com sucesso!'
    else
      flash.now[:alert] = 'Erro ao criar perfil...'
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])

    redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.' unless owner?
  end

  def update
    @profile = Profile.find(params[:id])

    if !profile_exists?
      redirect_to new_profile_path, alert: 'Cadastre seu perfil antes!'
    elsif !owner?
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @profile.update(profile_params)
      redirect_to @profile, notice: 'Perfil atualizado com sucesso!'
    else
      render :edit, alert: 'Erro ao atualizar perfil...'
    end
  end

  private

  def profile_exists?
    current_freelancer.profile.present?
  end

  def owner?
    @profile.freelancer == current_freelancer
  end

  def profile_params
    params.require(:profile).permit(:full_name, :social_name, :birth_date,
                                    :formation, :description, :photo,
                                    :occupation_area_id, :freelancer_id)
  end
end
