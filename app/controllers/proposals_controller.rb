class ProposalsController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[new create edit update]

  def show
    @project = Project.find(params[:project_id])
    @proposal = Proposal.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @proposal = Proposal.new

    @existing_proposal = Proposal.find_by(freelancer: current_freelancer)
    if @existing_proposal && @existing_proposal.project == @project
      redirect_to project_proposal_path(@existing_proposal.project, @existing_proposal), alert: "Uma proposta sua já existe para '#{@project.title}'!"
    end
  end
  
  def create
    @project = Project.find(params[:project_id])
    @proposal = Proposal.new(proposal_params)
    @proposal.freelancer = current_freelancer
    @proposal.project = @project

    @existing_proposal = Proposal.find_by(freelancer: current_freelancer)
    if @existing_proposal && @existing_proposal.project == @project
      redirect_to project_proposal_path(@existing_proposal.project, @existing_proposal), alert: "Uma proposta sua já existe para '#{@project.title}'!"
    elsif @proposal.save
      redirect_to [@project, @proposal]
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @proposal = Proposal.find(params[:id])

    if @proposal.freelancer != current_freelancer
      redirect_to root_path, alert: "[EDIT] Você não é o usuário correto! ✋🏻😡"
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @proposal = Proposal.find(params[:id])

    if @proposal.freelancer != current_freelancer
      redirect_to root_path, alert: "[UPDATE] Você não é o usuário correto! ✋🏻😡"
    elsif @proposal.update(update_proposal_params)
      redirect_to [@project, @proposal]
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @proposal = Proposal.find(params[:id])

    if @proposal.freelancer != current_freelancer
      redirect_to root_path, alert: "[DESTROY] Você não é o usuário correto! ✋🏻😡"
    elsif @proposal.destroy
      redirect_to @project
    else
      render @proposal
    end
  end

  def accept
    
  end

  def reject
    
  end

  def my_proposals
    @project = Project.find(params[:project_id])
    @proposals = @project.proposals
  end

  private

  def proposal_params
    params.require(:proposal).permit(:description, :hour_rate, :weekly_hours,
                                     :project_id, :freelancer_id)
  end

  def update_proposal_params
    params.require(:proposal).permit(:description, :hour_rate, :weekly_hours)
  end
end