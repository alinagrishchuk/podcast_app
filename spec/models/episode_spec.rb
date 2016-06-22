require 'rails_helper'

RSpec.describe Episode, type: :model do
  let(:podcast) { create(:podcast)}
  before { @episode = create(:episode, podcast: podcast) }
  subject { @episode }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:podcast) }
  it { expect(@episode.podcast).to eq podcast}

  describe "when podcast_id is not present" do
    before { @episode.podcast_id = nil }
    it { should_not be_valid }
  end
end
