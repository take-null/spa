module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        @notifications = current_api_v1_user.passive_notifications
        @notifications.where(checked: false).each do |notification|
          #notification.update_attributes(checked: false)
        #end
        #ary = @notifications.where(checked: false).map do |notification|
          #{user: notification.user.visited_id}
        #end
        #render json: @notifications 
      end
    end
  end
end