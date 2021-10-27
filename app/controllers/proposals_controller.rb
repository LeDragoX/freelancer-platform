class ProposalsController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[new create edit update]
  before_action :authenticate_user!, only: %i[my_proposals]
  before_action :require_log_in!, only: %i[show]

  def show
    @project = Project.find(params[:project_id])
    @proposal = Proposal.find(params[:id])

    if (user_signed_in? && @proposal.project.user == current_user) || (freelancer_signed_in? && @proposal.freelancer == current_freelancer)
      return
    else
      redirect_to root_path, alert: "Você não pode vizualizar esta proposta."
    end
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
    elsif @proposal.freelancer != current_freelancer
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @proposal.save
      redirect_to [@project], notice: "Proposta criada com sucesso!"
    else
      flash.now[:alert] = "Erro ao criar proposta"
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @proposal = Proposal.find(params[:id])

    if @proposal.freelancer != current_freelancer
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @proposal = Proposal.find(params[:id])

    if @proposal.freelancer != current_freelancer
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @proposal.update(update_proposal_params)
      redirect_to [@project], notice: "Proposta atualizada com sucesso!"
    else
      flash.now[:alert] = "Erro ao atualizar proposta"
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @proposal = Proposal.find(params[:id])

    if @proposal.freelancer != current_freelancer
      redirect_to root_path, alert: "Você não possui permissão para executar esta ação."
    elsif @proposal.destroy
      redirect_to @project, notice: "Proposta deletada com sucesso!"
    else
      flash.now[:alert] = "Erro ao deletar proposta"
      render @proposal
    end
  end

  def accept
    
  end

  def reject
    
  end

  private

  def proposal_params
    params.require(:proposal).permit(:description, :hour_rate, :weekly_hours,
                                     :delivery_estimate,
                                     :project_id, :freelancer_id)
  end

  def update_proposal_params
    params.require(:proposal).permit(:description, :hour_rate, :weekly_hours,
                                     :delivery_estimate)
  end
end