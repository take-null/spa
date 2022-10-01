module AuthorizationSpecHelper
  def sign_in(_user)
    post '/api/v1/auth/sign_in/',
         params: { email: current_user.email, password: current_user.password },
         as: :json

    response.headers.slice('client', 'uid', 'token-type', 'access-token')
  end
end
