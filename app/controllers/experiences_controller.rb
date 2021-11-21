class ExperiencesController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[new create edit update destroy]
  before_action :require_log_in!, only: %i[show]
  before_action :authenticate_admin!, only: %i[index] # Breaking on purpose

  # Needs Profile and Experiences Models
  def index
    # TODO: Implement admin
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])
  end

  def new
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.new

    redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.' unless verified_profile?
  end

  def create
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.new(experience_params)

    if !owner?
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @experience.save
      redirect_to [@profile, @experience], notice: 'Experiência criada com sucesso!'
    else
      render :new, alert: 'Erro ao criar experiência...'
    end
  end

  def edit
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])

    redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.' unless owner?
  end

  def update
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])

    if !owner?
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @experience.update(update_experience_params)
      redirect_to [@profile, @experience], notice: 'Experiência atualizada com sucesso!'
    else
      render :edit, alert: 'Erro ao atualizar experiência...'
    end
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])

    if !owner?
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @experience.destroy
      redirect_to profile_path(@profile), notice: 'Experiência deletada com sucesso!'
    else
      render :show, alert: 'Erro ao deletar experiência...'
    end
  end

  private

  def verified_profile?
    freelancer_signed_in? && @profile == current_freelancer.profile
  end

  def owner?
    @experience.profile.freelancer == current_freelancer
  end

  def experience_params
    params.require(:experience).permit(:title, :started_at, :ended_at,
                                       :description, :profile_id)
  end

  def update_experience_params
    params.require(:experience).permit(:title, :started_at, :ended_at,
                                       :description)
  end
end
