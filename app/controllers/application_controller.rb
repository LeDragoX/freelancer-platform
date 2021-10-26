class ApplicationController < ActionController::Base
  before_action :freelancer_with_profile? if :freelancer_signed_in?

  private

  def require_log_in!
    if !user_signed_in? && !freelancer_signed_in?
      current_page = request.env['REQUEST_URI']
      allowed_routes = [
                        root_path, new_freelancer_session_path, new_user_session_path,
                        cancel_freelancer_registration_path, new_freelancer_registration_path, edit_freelancer_registration_path, freelancer_registration_path,
                        new_freelancer_password_path, edit_freelancer_password_path, freelancer_password_path,
                        cancel_user_registration_path, new_user_registration_path, edit_user_registration_path, user_registration_path,
                        new_user_password_path, edit_user_password_path, user_password_path
                      ]

      if !(allowed_routes.include? current_page)
        redirect_to root_path, alert: "Você precisa estar logado para acessar esta seção."
      end
    end
  end

  def freelancer_with_profile?
    if freelancer_signed_in? && current_freelancer.profile.blank?
      current_page = request.env['REQUEST_URI']
      allowed_freelancer_routes = [new_profile_path, profiles_path, destroy_freelancer_session_path]

      if !(allowed_freelancer_routes.include? current_page)
        @profile = Profile.new
        flash.now[:alert] = "Você precisa criar um perfil antes de prossseguir, nem tente burlar."
        # render "profiles/new", object: @profile # breaks rspec ./spec/system/freelancer_register_profile_spec.rb:6
      end
    end
  end
end