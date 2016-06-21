require 'rails_helper'

RSpec.describe Podcast, type: :model do
  before { @podcast = FactoryGirl.create(:podcast) }
  subject { @podcast }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:itunes) }
  it { should respond_to(:stitcher) }
  it { should respond_to(:podbay) }

end
