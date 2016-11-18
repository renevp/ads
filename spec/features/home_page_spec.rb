require 'rails_helper'

feature 'home_page' do

  scenario 'advertisement public home page' do
    advertisement = FactoryGirl.create(:published_advertisement, title: 'Dollar sell')
    visit("/")

    expect(page).to have_content('Dollar sell')
  end

  scenario 'show just public advertisements' do
    advertisement = FactoryGirl.create(:published_advertisement, title: 'Dollar sell')
    advertisement2 = FactoryGirl.create(:advertisement, title: 'Dollar buy')
    visit("/")

    expect(page).to have_content('Dollar sell')
    expect(page).to have_no_content('Dollar buy')
  end

  scenario 'no advertisements' do
    visit("/")
    expect(page).to have_content('No sell advertisements published yet.')
    expect(page).to have_content('No buy advertisements published yet.')
  end
end
