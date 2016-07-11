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

  describe  "when set tags by string" do
    let(:tags){ "tag#1, tag#2, tag#3" }
    let(:episode){ build(:episode) }

    before do
      episode.all_tags = tags
      episode.save
    end

    specify { expect(episode.all_tags).to eq tags }
    specify { expect(episode.tags.count).to eq 3 }
  end

  describe "when find episodes by tag name" do
    let(:tag1){'tag#1'}
    let!(:empty_episode){ create(:episode) }
    let!(:tagged_episode){ create(:episode, title:"tagged",all_tags: "#{tag1}, tag#2") }

    it "should return 0 episode for not existing tag" do
      expect(Episode.tagged_with("NotExist").count).to eq 0
    end

    it "should return tagged episodes" do
      expect(Episode.tagged_with(tag1).map(&:title)).to eq(["tagged"])
    end
  end
end
