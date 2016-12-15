# Preview all emails at http://localhost:3000/rails/mailers/message
class MessagePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/message/new_message
  def new_message
    MessageMailer.new_message
  end

end
