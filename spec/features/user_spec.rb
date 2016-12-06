require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/user_messages_page'

feature "user page" do
  scenario 'user public page'do
    user = FactoryGirl.create(:user, username: 'maryx')
    visit("/users/#{user.id}")
    expect(page).to have_content('maryx')
  end

  let(:sender) { FactoryGirl.create(:user) }
  let(:recipient) { FactoryGirl.create(:user) }
  let(:login_form) { LoginForm.new }

  background do
    login_form.visit_page.login_as(recipient)
  end

  let(:message) { FactoryGirl.create(:message, sender: sender, recipient: recipient, body: 'Message 1') }
  let(:user_messages_page) { UserMessagesPage.new }

  scenario "show user's messages" do
    user_messages_page.messages
    print page.html
    expect(page).to have_content('Message 1')
  end
end
