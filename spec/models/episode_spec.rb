require 'rails_helper'

RSpec.describe Episode, type: :model do
  let(:podcast) { create(:podcast) }
  before { @episode = build(:episode, podcast: podcast) }
  subject { @episode }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:podcast) }
  it { expect(@episode.podcast).to eq podcast}

  describe "when podcast_id is not present" do
    before { @episode.podcast_id = nil }
    it { should_not be_valid }
  end

  describe  "should create tag by string" do
    let(:tags){ "tag#1, tag#2, tag#3" }
    let(:episode){ build(:episode, podcast: podcast) }

    before do
      episode.all_tags = tags
      episode.save
    end

    specify { expect(episode.all_tags).to eq tags }
    it { expect(episode.tags.count).to eq 3 }
  end

end
