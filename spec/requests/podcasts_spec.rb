require 'rails_helper'

RSpec.describe "Podcasts", type: :request do
  subject { page }

  describe "when visit podcasts page" do
    let(:tags) { ["tag#1", "tag#2"] }

    before do
      10.times{ create(:podcast) }
      @last_podcast = create(:podcast_with_episodes_and_tags, title: "tagged", all_tags: tags.join(", "))
      visit  podcasts_path
    end

    it "should display banner" do
      should have_selector('#banner.podcasts_banner')
    end

    it "should display search form" do
      should have_selector('section.search-form')
    end

    it "should have tags links with its count" do
      within '.links' do
        tags.each do |tag|
          should have_link("##{tag} 1",podcasts_path )
        end
      end
    end

    it  "should display podcasts" do
      within '#podcasts .js_ajax_container' do
        should have_selector('li', count: 4)
        should have_link('', href: podcast_path(@last_podcast))
        should have_selector('div.pagination')

        within "#podcast_#{@last_podcast.id} .podcast_overview" do
          should have_selector('h2',text: @last_podcast.title)
          should have_selector('p.episode_count')
        end
      end
    end
  end
end
