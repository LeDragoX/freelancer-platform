class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :require_log_in!, only: %i[show my_projects]

  def show
    @project = Project.find(params[:id])
    @user = @project.user
    @proposals = @project.proposals

    if freelancer_signed_in?
      @freelancer_proposal = @project.proposals.find_by(freelancer: current_freelancer)
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      redirect_to @project, notice: "Projeto criado com sucesso!"
    else
      flash.now[:alert] = "Erro ao salvar projeto"
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])

    if @project.user != current_user
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.user != current_user
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @project.update(project_params)
      redirect_to @project, notice: "Projeto atualizado com sucesso!"
    else
      flash.now[:alert] = "Erro ao atualizar projeto"
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])

    if @project.user != current_user
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @project.destroy
      redirect_to my_projects_projects_path, notice: "Projeto deletado com sucesso!"
    else
      flash.now[:alert] = "Erro ao deletar projeto"
      render @project
    end
  end

  def my_projects
    if user_signed_in?
      @projects = current_user.projects
    elsif freelancer_signed_in?
      @proposals = Proposal.all
      @projects = []
      @proposals.each do |proposal|
        if proposal.freelancer == current_freelancer
          @projects << proposal.project
        end
      end
    end
  end

  def my_proposals
    @projects = current_user.projects
  end

  private
  
  def project_params
    params.require(:project).permit(:title, :description, :wanted_skills,
                                    :max_hour_rate, :deadline, :available,
                                    :job_type_id)
  end
end