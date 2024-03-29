module Api
  module V1
    class SurveysController < ApplicationController
      def create
        @survey = current_api_v1_user.surveys.new(survey_params)
        if @survey.save
          SurveyMailer.send_mail(@survey).deliver_now
          render json: @survey, status: :ok
        else
          render json: @survey.errors, status: :internal_server_error
        end
      end

      private

      def survey_params
        params.permit(:title, :content)
      end
    end
  end
end
