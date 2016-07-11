require "rails_helper"

describe "adding podcast" do
  it "allows a user to create podcast" do
    visit new_podcast_registration_path
    fill_in 'Title', with: 'Podcast title'
    fill_in 'Email', with: 'email@example.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    visit  edit_podcast_registration_path
    expect(page).to have_content("Podcast title")
    expect(page).to have_field('Title', with: 'Podcast title')
    expect(page).to have_field('Email', with: 'email@example.com')
  end

end