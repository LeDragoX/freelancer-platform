class ProposalsController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[new create edit update]
  before_action :authenticate_user!, only: %i[accept reject]
  before_action :require_log_in!, only: %i[show]

  def show
    @project = Project.find(params[:project_id])
    @proposal = @project.proposals.find(params[:id])

    if (user_signed_in? && @proposal.project.user == current_user) || (freelancer_signed_in? && owner?)
      nil
    else
      redirect_to root_path, alert: 'Você não pode vizualizar esta proposta.'
    end
  end

  def new
    @project = Project.find(params[:project_id])
    @proposal = @project.proposals.new

    @existing_proposal = Proposal.find_by(freelancer: current_freelancer)
    if proposals_exists?
      redirect_to project_proposal_path(@existing_proposal.project, @existing_proposal),
                  alert: "Uma proposta sua já existe para '#{@project.title}'!"
    end
  end

  def create
    @project = Project.find(params[:project_id])
    @proposal = @project.proposals.new(proposal_params)
    @proposal.freelancer = current_freelancer

    @existing_proposal = Proposal.find_by(freelancer: current_freelancer)
    if proposals_exists?
      redirect_to project_proposal_path(@existing_proposal.project, @existing_proposal),
                  alert: "Uma proposta sua já existe para '#{@proposal.project.title}'!"
    elsif !owner?
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @proposal.save
      redirect_to [@proposal.project], notice: 'Proposta criada com sucesso!'
    else
      render :new, alert: 'Erro ao criar proposta...'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @proposal = @project.proposals.find(params[:id])

    redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.' unless owner?
  end

  def update
    @project = Project.find(params[:project_id])
    @proposal = @project.proposals.find(params[:id])

    if !owner?
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @proposal.update(proposal_update_params)
      redirect_to [@project], notice: 'Proposta atualizada com sucesso!'
    else
      render :edit, alert: 'Erro ao atualizar proposta...'
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @proposal = @project.proposals.find(params[:id])

    if !owner?
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @proposal.destroy
      redirect_to @project, notice: 'Proposta deletada com sucesso!'
    else
      render @proposal, alert: 'Erro ao deletar proposta...'
    end
  end

  def accept
    @project = Project.find(params[:project_id])
    @proposal = @project.proposals.find(params[:proposal_id])

    if @project.user != current_user
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @proposal.accepted!
      redirect_to [@project, @proposal], notice: 'Proposta aceita com sucesso!'
    else
      render [@project, @proposal], alert: 'Erro ao aceitar proposta...'
    end
  end

  def reject
    @project = Project.find(params[:project_id])
    @proposal = @project.proposals.find(params[:proposal_id])

    if @project.user != current_user
      redirect_to root_path, alert: 'Você não possui permissão para executar esta ação.'
    elsif @proposal.rejected!
      redirect_to [@project, @proposal], notice: 'Proposta recusada com sucesso!'
    else
      render [@project, @proposal], alert: 'Erro ao recusar proposta...'
    end
  end

  private

  def proposals_exists?
    @existing_proposal && @existing_proposal.project == @project
  end

  def owner?
    @proposal.freelancer == current_freelancer
  end

  def proposal_params
    params.require(:proposal).permit(:description, :hour_rate, :weekly_hours,
                                     :delivery_estimate,
                                     :project_id, :freelancer_id)
  end

  def proposal_update_params
    params.require(:proposal).permit(:description, :hour_rate, :weekly_hours,
                                     :delivery_estimate)
  end
end
