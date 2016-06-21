require 'rails_helper'

RSpec.describe "Podcasts", type: :request do
  subject { page }

  describe "create podcast profile" do
    let(:podcast) { build(:podcast) }

    before do
      sign_up(podcast)
      podcast = Podcast.first
    end

    it "should set podcast attributes" do
      expect(podcast.title).to eq "title"
    end
  end

  describe "edit podcast profile" do
    let(:podcast) { create(:podcast) }

    before do
      sign_in(podcast)
      visit edit_podcast_registration_path

      podcast.title = "some title"
      podcast.description = "some description"
      podcast.itunes = "some itunes"
      podcast.stitcher = "some stitcher"
      podcast.podbay = "some podbay"

      valid_podcast_edit(podcast)
    end

    it "should redirect to home page" do
      expect(page.current_path).to eq root_path
    end

    it "should change podcast attributes" do
     podcast.reload
     expect(podcast.title).to eq "some title"
     expect(podcast.description).to eq "some description"
     expect(podcast.itunes).to eq "some itunes"
     expect(podcast.stitcher).to eq "some stitcher"
    end
  end
end
