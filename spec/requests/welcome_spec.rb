require 'rails_helper'

RSpec.describe "Welcome", type: :request do
  subject { page }

  describe "GET /" do
    before { visit root_path }

    describe "should have the right links on the layout" do

      describe "for non-signed in users" do
        it { should have_link('Sign in', href: new_podcast_session_path) }
        it { should have_link('Create a podcast', href: new_podcast_registration_path) }
        it { have_link('Explore') }
      end

      describe "for signed in users" do
        let(:podcast) { create(:podcast) }
        before { sign_in(podcast) }

        it { should_not have_link('Sign in', href: new_podcast_session_path) }
        it { should have_link('Dashboard', href:  authenticated_root_path) }
        it { should have_link('Sign Out', href: destroy_podcast_session_path) }
        it { have_link('Explore') }
      end

    end

  end
end
