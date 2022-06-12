class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies
  skip_before_action :verify_authenticity_token, if: :devise_controller?, raise: false
  before_action :config_permitted_parameters, if: :devise_controller?

  def home
    render json: "hello world"
  end

  private
    def config_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :profile, :age, :locate])
    end

    def after_sign_in_path_for(resource)
      api_v1_users_path
    end
end