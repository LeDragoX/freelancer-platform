class ApplicationController < ActionController::Base
  before_action :freelancer_with_profile?

  private

  def require_log_in!
    current_page = request.env['REQUEST_URI']
    unless (user_signed_in? || freelancer_signed_in?) && allowed_routes.exclude?(current_page)
      redirect_to root_path, alert: 'Você precisa estar logado para acessar esta seção.'
    end
  end

  def freelancer_with_profile?
    current_page = request.env['REQUEST_URI']
    allowed_routes_freelancer = [new_profile_path, profiles_path, destroy_freelancer_session_path]
    if freelancer_signed_in? && current_freelancer.profile.blank? && allowed_routes_freelancer.exclude?(current_page)
      @profile = Profile.new
      flash.now[:alert] = 'Você precisa criar um perfil antes de prossseguir, nem tente burlar.'
    end
  end
end

def allowed_routes
  [root_path, new_freelancer_session_path, new_user_session_path,
   cancel_freelancer_registration_path, new_freelancer_registration_path, edit_freelancer_registration_path,
   freelancer_registration_path, new_freelancer_password_path, edit_freelancer_password_path,
   freelancer_password_path, cancel_user_registration_path, new_user_registration_path,
   edit_user_registration_path, user_registration_path, new_user_password_path,
   edit_user_password_path, user_password_path]
end
