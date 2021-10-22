class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy my_projects]

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
      redirect_to @project
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])

    if @project.destroy
      redirect_to my_projects_projects_path
    else
      render @project
    end
  end

  def my_projects
    @projects = current_user.projects
  end

  private
  
  def project_params
    params.require(:project).permit(:title, :description, :wanted_skills,
                                    :max_hour_rate, :deadline, :available,
                                    :job_type_id)
  end
end