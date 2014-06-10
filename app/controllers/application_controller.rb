class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # load_and_authorize_resource except: :create
  check_authorization unless: :devise_controller?, only: :destroy
  before_action :authorize_destroy, unless: :devise_controller?, only: :destroy
  protect_from_forgery with: :exception
  before_filter :authenticate_admin!


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :roles
    devise_parameter_sanitizer.for(:account_update) << :roles
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end

  private

  def authorize_destroy
    authorize! :destroy, self.class
  end

end
