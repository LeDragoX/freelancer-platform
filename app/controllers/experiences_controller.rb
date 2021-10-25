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
    @experience = Experience.find(params[:id])
  end

  def new
    @profile = Profile.find(params[:profile_id])
    @experience = Experience.new

    if !(freelancer_signed_in? && @profile == current_freelancer.profile)
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    end
  end

  def create
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.new(experience_params)

    if !(freelancer_signed_in? && @profile == current_freelancer.profile)
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @experience.save
      flash[:notice] = "Experiência criada com sucesso!"
      redirect_to [@profile, @experience]
    else
      flash.now[:alert] = "Erro ao criar experiência"
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])

    if !(@experience.profile.freelancer == current_freelancer)
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    end
  end

  def update
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])

    if !(@experience.profile.freelancer == current_freelancer)
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @experience.update(update_experience_params)
      flash[:notice] = "Experiência atualizada com sucesso!"
      redirect_to [@profile, @experience]
    else
      flash.now[:alert] = "Erro ao atualizar experiência"
      render :edit
    end
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.find(params[:id])

    if !(@experience.profile.freelancer == current_freelancer)
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @experience.destroy
      flash[:notice] = "Experiência deletada com sucesso!"
      redirect_to profile_path(@profile)
    else
      flash.now[:alert] = "Erro ao deletar experiência"
      render :show
    end
  end

  private

  def experience_params
    params.require(:experience).permit(:title, :started_at, :ended_at,
                                       :description, :profile_id)
  end

  def update_experience_params
    params.require(:experience).permit(:title, :started_at, :ended_at,
                                       :description)
  end
end