require 'rails_helper'

RSpec.describe Podcast, type: :model do
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
