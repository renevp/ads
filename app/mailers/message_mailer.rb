class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.new_message.subject
  #
  def new_message(message)
    @message = message
    @greeting = "Hi " + @message.recipient.full_name
    @text = "Log in to see your message:"

    mail to: message.recipient.email
  end
end
