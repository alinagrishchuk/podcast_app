require 'rails_helper'

RSpec.describe Podcast, type: :model do

  describe "check validation of record" do
    before { @podcast = FactoryGirl.create(:podcast) }
    subject { @podcast }

    it { should respond_to(:title) }
    it { should respond_to(:description) }
    it { should respond_to(:itunes) }
    it { should respond_to(:stitcher) }
    it { should respond_to(:podbay) }
    it { should respond_to(:episodes) }

    it "fails validation with not url reference" do
      @podcast.itunes   = 'it is not url'
      @podcast.stitcher = 'it is not url'
      @podcast.podbay   = 'it is not url'

      should_not be_valid

      expect(@podcast.errors[:itunes].size).to  eq 1
      expect(@podcast.errors[:stitcher].size).to  eq 1
      expect(@podcast.errors[:podbay].size).to  eq 1
    end
  end

  describe "should calculate episodes count" do
    let! (:podcast_without_episodes) { create(:podcast) }
    let! (:podcast_with_episodes) { create(:podcast_with_episodes_and_tags) }

    specify { expect(Podcast).to respond_to(:include_episodes_count) }

    it "should return 0 episode" do
      expect(Podcast.include_episodes_count.
        find(podcast_without_episodes.id).episodes_count).to eq 0
    end

    it "should return 1 episode" do
      expect(Podcast.include_episodes_count.
        find(podcast_with_episodes.id).episodes_count).to eq 1
    end
  end

  describe "should find podcasts by its episodes tag" do
    let (:tag) {'tag'}
    let!(:podcast) { create(:podcast) }
    let!(:tagged_podcast) { create(:podcast_with_episodes_and_tags, title: "tagged", all_tags: tag) }

    specify { expect(Podcast).to respond_to(:tagged_with) }

    it "should return 0 podcast for not existing tag" do
      expect(Podcast.tagged_with("NotExist").count).to eq 0
    end

    it "should return tagged podcasts" do
      expect(Podcast.tagged_with(tag).count).to eq 1
      expect(Podcast.tagged_with(tag).map(&:title)).to eq(["tagged"])
    end

  end

end


