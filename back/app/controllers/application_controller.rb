class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies
  skip_before_action :verify_authenticity_token, if: :devise_controller?, raise: false
  before_action :config_permitted_parameters, if: :devise_controller?
  before_action :set_host

  def index
    render json: { status: 200 }
  end

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  private

  def config_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :profile, :age, :locate])
  end

  def after_sign_in_path_for(_resource)
    api_v1_users_path
  end
end
