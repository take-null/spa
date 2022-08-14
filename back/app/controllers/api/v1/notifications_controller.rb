module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: [:index, :destroy]

      def index
        @notifications = current_api_v1_user.passive_notifications
        render json: @notifications, status: 200
      end

      def destroy
        @notification = Notification.find(params[:id])
        @notification.destroy
        render json: @notifications, status: 200
      end
    end
  end
end