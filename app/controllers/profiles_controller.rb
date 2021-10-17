class ProfilesController < ApplicationController
  before_action :authenticate_freelancer!, only: %i[edit update]

  def show
    begin
      @profile = Profile.find(params[:id])
    rescue => exception
      redirect_to root_path, alert: "#{t(:freelancer, scope: "activerecord.models")} não possui Perfil (#{exception.class}: #{exception})"
    end
  end
end