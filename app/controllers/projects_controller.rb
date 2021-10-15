class ProjectsController < ApplicationController

  def show
    @project = Project.find(params[:id])
    @user = @project.user
  end

  private
  
  def project_params
    params.require(:project).permit(:title, :description, :wanted_skills,
                                    :max_hour_rate, :deadline, :job_type,
                                    :available, :status)
  end
end
