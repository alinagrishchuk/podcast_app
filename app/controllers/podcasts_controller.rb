class PodcastsController < ApplicationController
  before_action :find_podcast, only: [:show]
  before_action :find_episode, only: [:show]

  def index
    @podcasts = Podcast.all
  end
  def show
  end

  private

  def find_podcast
      @podcast = Podcast.find(params[:id])
  end

  def find_episode
    @episodes = Episode.where(podcast_id: @podcast)
  end
end
