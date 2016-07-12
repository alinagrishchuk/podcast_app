require "rails_helper"

describe "editing podcast" do
  let!(:podcast)      { create(:podcast) }

  let!(:title)        { "new title" }
  let!(:description)  { "new description" }
  let(:itunes)        { "http://stackoverflow.com/" }
  let(:stitcher)      { "https://stackoverflow.com/" }
  let(:podbay)        { "http://stackoverflow.com/"}

  before do
    sign_in(podcast)
    visit edit_podcast_registration_path

    podcast.title = title
    podcast.description = description
    podcast.itunes = itunes
    podcast.stitcher = stitcher
    podcast.podbay = podbay

    valid_podcast_edit(podcast)
  end

  it "allows a user to modify podcast attributes" do
    expect(page.current_path).to eq root_path
    podcast.reload
    expect(podcast.title).to eq title
    expect(podcast.description).to eq description
    expect(podcast.itunes).to eq itunes
    expect(podcast.stitcher).to eq stitcher
    expect(podcast.podbay).to eq podbay
  end
end