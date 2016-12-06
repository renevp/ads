class UserMessagesPage
  include Capybara::DSL

  def visit_page(user, message)
    visit("/users/#{user.id}/messages/#{message.id}")
    self
  end

  def messages
    click_on("Messages")
    self
  end
end
