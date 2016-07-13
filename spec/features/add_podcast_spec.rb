require "rails_helper"

describe "adding podcast" do
  before(:all) do
    Capybara.current_driver = :webkit
  end
  it "allows a user to create podcast", :js => true do
    visit new_podcast_registration_path

    fill_in 'Title', with: 'Podcast title'
    attach_file('podcast_thumbnail', File.join(Rails.root, '/spec/support/example.jpg'))
    fill_in 'Email', with: 'email@example.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    expect(page).to have_content("example.jpg")

    click_on 'Sign up'

    visit  edit_podcast_registration_path
    expect(page).to have_content("Podcast title")
    expect(page).to have_field('Title', with: 'Podcast title')
    expect(page).to have_field('Email', with: 'email@example.com')
    expect(page).to have_selector('img.thumbnail')

  end

end