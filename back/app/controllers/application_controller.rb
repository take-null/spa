class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies
  skip_before_action :verify_authenticity_token, if: :devise_controller?, raise: false
  def home
    render json: "hello world"
  end

end
