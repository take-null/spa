# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  protected

  # ユーザー情報編集時はパスワードの入力は省略する
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # 更新後のパスを指定し、マイページに遷移させる
  def after_update_path_for(_resource)
    user_path(@user.id)
  end
end
