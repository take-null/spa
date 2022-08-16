module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        @notifications = current_api_v1_user.passive_notifications
        render json: { status: 200, data: @notifications }
      end

      def destroy
        @notification = Notification.find(params[:id])
        @notification.destroy
        render json: { status: 200, data: @notifications }
      end
    end
  end
end