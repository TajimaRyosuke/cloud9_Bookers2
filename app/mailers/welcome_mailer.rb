class WelcomeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_mailer.send_when_signup.subject
  #
  def send_when_signup(email, name)
    @name = name
    mail to: email, subject: '会員登録が完了いたしました。'
  end

  def notify_user
        default to: -> { User.pluck(:email) }
        mail(subject: "Bookers2日報")
  end
end
