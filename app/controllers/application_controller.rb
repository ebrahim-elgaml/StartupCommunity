class ApplicationController < ActionController::Base

    # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

    
  # acts_as_token_authentication_handler_for User

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] },:first_name, :last_name, :email, :password, :password_confirmation , :is_employee, :current_sign_in_at, :created_at) }
  end


   private
      def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
      end
end
