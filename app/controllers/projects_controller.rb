class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy my_projects]

  def show
    @project = Project.find(params[:id])
    @user = @project.user
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

  def my_projects
    @projects = current_user.projects
  end

  private
  
  def project_params
    params.require(:project).permit(:title, :description, :wanted_skills,
                                    :max_hour_rate, :deadline, :job_type_id,
                                    :available, :status)
  end
end
