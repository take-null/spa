module Api
  module V1
    class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
      private

      def sign_up_params
        params.permit(:name, :email, :password, :password_confirmation)
      end

      def account_update_params
        params.permit(:name, :image, :email, :profile, :age, :locate)
      end
    end
  end
end
