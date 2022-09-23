module Api
  module V1
    class SurveysController < ApplicationController

      def create
        @survey = current_api_v1_user.surveys.new(survey_params)
        if @survey.save 
          SurveyMailer.send_mail(@survey).deliver_now
          render json: @survey, status: 200
        else
          render json: @survey.errors, status: 500
        end
      end

      private
        def survey_params
          params.permit(:title, :content)
        end

    end
  end
end
