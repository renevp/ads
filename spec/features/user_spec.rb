require 'rails_helper'

feature 'user page' do
  scenario 'user public page'do
    user = FactoryGirl.create(:user, username: 'maryx')
    visit("/users/#{user.id}")
    expect(page).to have_content('maryx')
  end
end
