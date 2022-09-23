class SurveyMailer < ApplicationMailer
  def send_mail(survey)
    @survey = survey
    mail(
      from: Rails.application.credentials.email[:survey],
      to: Rails.application.credentials.email[:admin],
      sublect: 'お問い合わせ通知'
    )
  end
end
