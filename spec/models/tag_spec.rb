require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "can count tag usage by episodes" do
    let (:tag) {'tag#1'}
    let (:tags) {"#{tag}, tag#2"}
    let (:not_used_tag) {'Not used'}
    let!(:tagged_podcast) { create(:podcast_with_episodes_and_tags, all_tags: tags) }

    it "should return row for every tag" do
      expect(Tag.usage.to_a.count).to eq(Tag.all.count)
    end

    it "should return row for every tag" do
      expect(Tag.usage.to_ary.find{ |t| t.name == tag }.count).to eq(1)
    end
  end
end
