require 'rails_helper'

feature 'advertisement page' do
  scenario 'advertisement public page' do
    advertisement = FactoryGirl.create(:advertisement, title: 'Dollar sell')
    visit("/advertisements/#{advertisement.id}")

    expect(page).to have_content('Dollar sell')
  end

  scenario 'show public advertisements' do
    advertisement = FactoryGirl.create(:published_advertisement, title: 'Dollar sell')
    advertisement2 = FactoryGirl.create(:published_advertisement, title: 'Dollar buy')
    visit("/advertisements/")

    expect(page).to have_content('Dollar sell')
    expect(page).to have_content('Dollar buy')
  end

  scenario 'no advertisements' do
    visit("/advertisements/")
    expect(page).to have_content('No advertisements published yet.')
  end
end
